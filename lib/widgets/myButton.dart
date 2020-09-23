import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  MyButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.yellow,
            width: 1.5,
          ),
        ),
        color: Color(0xff1a214f),
        child: Text(
          "NEXT",
          style: TextStyle(
              color: Color(0xffce0334),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
