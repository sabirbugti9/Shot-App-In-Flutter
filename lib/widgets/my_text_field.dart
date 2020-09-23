import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool obscureText;
  final IconData icon;
  final TextInputType keyborad;

  MyTextField(
      {this.name, this.obscureText, this.keyborad, this.controller, this.icon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyborad,
      obscureText: obscureText,
      decoration: InputDecoration(
        // prefixIcon: Icon(icon),
        // fillColor: Color(0x70d7eef5),
        // filled: true,
        hintText: name,
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide.none,
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
      ),
    );
  }
}
