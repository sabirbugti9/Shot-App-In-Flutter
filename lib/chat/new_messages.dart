import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();

  var _enterMessages = '';
  void _sendMessages() async {
    FocusScope.of(context).unfocus();
    User user = FirebaseAuth.instance.currentUser;
    final userData =
        await FirebaseFirestore.instance.collection('User').doc(user.uid).get();

    FirebaseFirestore.instance.collection('Chats').add(
      {
        'text': _enterMessages,
        'createdAt': Timestamp.now().millisecondsSinceEpoch.toString(),
        'UserId': user.uid,
        'UserName': userData.data()["UserName"],
        'userName': userData.data()["UserFacemaskPic"],
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 5),
            child: IconButton(
              icon: Icon(Icons.insert_emoticon),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send Messages'),
              onChanged: (value) {
                setState(() {
                  _enterMessages = value;
                });
              },
            ),
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enterMessages.trim().isEmpty ? null : _sendMessages)
        ],
      ),
    );
  }
}
