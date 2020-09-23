import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/model/usermodel.dart';
import 'package:shot_app/screens/home_page.dart';
import 'package:shot_app/screens/profile.dart';
import 'package:shot_app/widgets/myButton.dart';
import 'package:shot_app/widgets/mytextformField.dart';

class InfoEdit extends StatefulWidget {
  @override
  _InfoEditState createState() => _InfoEditState();
}

class _InfoEditState extends State<InfoEdit> {
  UserModel userModel;
  TextEditingController age;
  TextEditingController name;
  TextEditingController major;
  TextEditingController whatAbout;
  TextEditingController somethingAbout;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  bool isMale = false;
  void vaildation() async {
    if (name.text.isEmpty &&
        age.text.isEmpty &&
        major.text.isEmpty &&
        whatAbout.text.isEmpty &&
        somethingAbout.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (name.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (name.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (age.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Age Is Empty"),
        ),
      );
    } else if (int.parse(age.text) > 40 || int.parse(age.text) < 10) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Age Must Be > 10 And <40 "),
        ),
      );
    } else if (somethingAbout.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("About YourSelf Flied Is Empty "),
        ),
      );
    } else if (whatAbout.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("You Looking Flied Is Empty "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File _pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  String userUid;

  Future<String> _uploadImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("User").doc(userUid).update({
      "UserName": name.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserSomethingAbout": somethingAbout.text,
      "UserFacemaskPic": _pickedImage == null ? userModel.userImage : imageMap,
      "UserMajor": major.text,
      "UserAge": age.text,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer(
      {Color color, String startText, String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    age = TextEditingController(text: userModel.userAge);
    name = TextEditingController(text: userModel.userName);
    major = TextEditingController(text: userModel.userMajor);
    somethingAbout = TextEditingController(text: userModel.userSomeThing);
    whatAbout = TextEditingController(text: userModel.userWhatAbout);
    if (userModel.userGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName,
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: userModel.userInterest,
            startText: "Interest",
          ),
          _buildSingleContainer(
            endText: userModel.userGender,
            startText: "Gender",
          ),
          _buildSingleContainer(
            endText: userModel.userMajor,
            startText: "Major",
          ),
          _buildSingleContainer(
            endText: userModel.userAge,
            startText: "Age",
          ),
          _buildSingleContainer(
            endText: userModel.userWhatAbout,
            startText: "Looking For",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFliedPart() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "UserName",
            controller: name,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _buildSingleContainer(
              color: Colors.white,
              endText: isMale == true ? "Male" : "Female",
              startText: "Gender",
            ),
          ),
          MyTextFormField(
            name: "Major",
            controller: major,
          ),
          MyTextFormField(
            name: "SomeThing About",
            controller: somethingAbout,
          ),
          MyTextFormField(
            name: "Age",
            controller: age,
          ),
          MyTextFormField(
            name: "You Looking For",
            controller: whatAbout,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    print(userUid);
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: centerCircle == false
              ? edit == true
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          edit = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => Profile(),
                            ),
                          );
                        });
                      },
                    )
              : Container(),
          backgroundColor: Colors.transparent,
          actions: [
            centerCircle == false
                ? edit == false
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          vaildation();
                        },
                      )
                : Container(),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: myGradient,
          ),
          child: centerCircle == false
              ? ListView(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("User")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var myDoc = snapshot.data.docs;
                          myDoc.forEach((checkDocs) {
                            if (checkDocs.data()["UserId"] == userUid) {
                              userModel = UserModel(
                                userAge: checkDocs.data()["UserAge"],
                                userEmail: checkDocs.data()["UserEmail"],
                                userGender: checkDocs.data()["UserGender"],
                                userImage: checkDocs.data()["UserFacemaskPic"],
                                userInterest: checkDocs.data()["UserInterest"],
                                userMajor: checkDocs.data()["UserMajor"],
                                userName: checkDocs.data()["UserName"],
                                userSomeThing:
                                    checkDocs.data()["UserSomethingAbout"],
                                userWhatAbout:
                                    checkDocs.data()["UserYouLooking"],
                              );
                            }
                          });
                          return Container(
                            height: 650,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              maxRadius: 65,
                                              backgroundImage: _pickedImage ==
                                                      null
                                                  ? userModel.userImage == null
                                                      ? AssetImage(
                                                          "images/userImage.png")
                                                      : NetworkImage(
                                                          userModel.userImage)
                                                  : FileImage(_pickedImage)),
                                        ],
                                      ),
                                    ),
                                    edit == true
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .viewPadding
                                                        .left +
                                                    220,
                                                top: MediaQuery.of(context)
                                                        .viewPadding
                                                        .left +
                                                    110),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  myDialogBox(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Color(0xff746bc9),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  height: 385,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: edit == true
                                              ? _buildTextFormFliedPart()
                                              : _buildContainerPart(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: edit == false
                                      ? MyButton(
                                          onPressed: () {
                                            setState(() {
                                              edit = true;
                                            });
                                          },
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
