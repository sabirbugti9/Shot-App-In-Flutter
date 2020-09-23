import 'package:flutter/material.dart';

class MyFlatButton extends StatefulWidget {
  final String flatButtonText;
  final Function whenPressed;
  MyFlatButton({this.flatButtonText, this.whenPressed});
  @override
  _MyFlatButtonState createState() => _MyFlatButtonState();
}

class _MyFlatButtonState extends State<MyFlatButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.whenPressed,
      child: Text(
        '${widget.flatButtonText}',
        style: TextStyle(
          color: Color(0xfffe6ba7),
          fontSize: 16,
        ),
      ),
    );
  }
}
