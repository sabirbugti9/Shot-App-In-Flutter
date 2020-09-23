import 'package:flutter/material.dart';

class MessagesBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;

  MessagesBubble(
    this.message,
    this.userName,
    this.userImage,
    this.isMe, {
    this.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(20),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(20),
                  bottomLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      isMe
                          ? Text(
                              userName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text(
                              userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: isMe
              ? Container()
              : CircleAvatar(
                backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(userImage),
                ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
