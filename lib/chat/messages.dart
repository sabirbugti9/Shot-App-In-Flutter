import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shot_app/chat/messages_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chats')
          .orderBy('createdAt', descending: true)
          .limit(
            20,
          )
          .snapshots(),
      builder: (context, snapShota) {
        User user = FirebaseAuth.instance.currentUser;
        if (snapShota.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final deco = snapShota.data.docs;
        print(user.uid);
        return ListView.builder(
          reverse: true,
          itemCount: deco.length,
          itemBuilder: (context, index) => MessagesBubble(
            deco[index].data()['text'],
            deco[index].data()['UserName'],
            deco[index].data()['userName'],
            deco[index].data()['UserId'] == user.uid,
            key: ValueKey(deco[index].documentID),
          ),
        );
      },
    );
  }
}
