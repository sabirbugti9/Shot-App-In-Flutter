import 'package:flutter/material.dart';

class RowSlider extends StatelessWidget {
  final bool first, second, third;
  RowSlider({this.first, this.second, this.third});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fiber_manual_record,
            color: first == true ? Colors.white : Colors.black,
            size: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.fiber_manual_record,
            color: second == true ? Colors.white : Colors.black,
            size: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.fiber_manual_record,
            color: third == true ? Colors.white : Colors.black,
            size: 15,
          ),
        ],
      ),
    );
  }
}
