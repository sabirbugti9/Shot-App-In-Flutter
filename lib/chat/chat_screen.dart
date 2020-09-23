import 'dart:ui';

import 'package:shot_app/chat/messages.dart';
import 'package:shot_app/chat/new_messages.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/screens/home_page.dart';
import 'package:shot_app/screens/profile.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _messaging.requestNotificationPermissions();
    _messaging.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: myGradient,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      height: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (ctx) => ChatScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 70,
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: AssetImage("images/mail.png"),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      'SHOTS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'MADE',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 55,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('images/logo.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => Profile(),
                          ),
                        );
                      },
                      child: Container(
                          height: 50,
                          child: Image(
                            image: AssetImage("images/profile.png"),
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Messages(),
              ),
              NewMessages(),
            ],
          ),
        ),
      ),
    );
  }
}
