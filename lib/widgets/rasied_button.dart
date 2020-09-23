import 'package:flutter/material.dart';

class RasiedButton extends StatefulWidget {
  final String buttonText;
  final Function whenPrassed;
  final Color colors;
  final Color textColors;

  RasiedButton(
      {this.textColors, this.colors, this.buttonText, this.whenPrassed});
  @override
  _RasiedButtonState createState() => _RasiedButtonState();
}

class _RasiedButtonState extends State<RasiedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        child: Text(
          '${widget.buttonText}',
          style: TextStyle(
              color: widget.textColors,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        color: widget.colors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: widget.whenPrassed,
      ),
    );
  }
}
