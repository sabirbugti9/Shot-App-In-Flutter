import 'package:flutter/material.dart';

class UserModel {
  final String userName;
  final String userImage;
  final String userSomeThing;
  final String userWhatAbout;
  final String userGender;
  final String userMajor;
  final String userEmail;
  final String userInterest;
  final String userAge;
  UserModel({
    @required this.userEmail,
    @required this.userMajor,
    @required this.userAge,
    @required this.userGender,
    @required this.userImage,
    @required this.userInterest,
    @required this.userName,
    @required this.userSomeThing,
    @required this.userWhatAbout,
  });
}
