import 'package:flutter/material.dart';

class TopLogoAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 150,
              child: Image(
                image: AssetImage("images/logo.png"),
              ),
            ),
            Text(
              "SHOTS",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Color(0xff1a214f),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
