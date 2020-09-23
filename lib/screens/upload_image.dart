import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/screens/home_page.dart';
import 'package:shot_app/widgets/myButton.dart';
import 'package:shot_app/widgets/row_silder.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _faceImage, aboutImage, memeImage, bestImage;
  PickedFile _facePick, aboutPick, memePick, bestPick;
  Future<void> getFaceImage({ImageSource source}) async {
    _facePick = await ImagePicker().getImage(source: source);
    if (_facePick != null) {
      setState(() {
        _faceImage = File(_facePick.path);
      });
    }
  }

  Future<void> getAboutImage({ImageSource source}) async {
    aboutPick = await ImagePicker().getImage(source: source);
    if (aboutPick != null) {
      setState(() {
        aboutImage = File(aboutPick.path);
      });
    }
  }

  Future<void> getMemeImage({ImageSource source}) async {
    memePick = await ImagePicker().getImage(source: source);
    if (memePick != null) {
      setState(() {
        memeImage = File(memePick.path);
      });
    }
  }

  Future<void> getBestImage({ImageSource source}) async {
    bestPick = await ImagePicker().getImage(source: source);
    if (bestPick != null) {
      setState(() {
        bestImage = File(bestPick.path);
      });
    }
  }

  Widget _buildSinglePictureProduct({File image}) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Image(
        fit: BoxFit.cover,
        image: image == null ? AssetImage("images/logo.png") : FileImage(image),
        color: image == null ? Color(0xff1a214f) : null,
      ),
    );
  }

  String userUid;

  Future<String> _uploadFacemaskImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> _uploadAboutImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid about");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> _uploadMemeImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid meme");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> _uploadBestImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid best");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool isLoading = false;
  void userDetailUpdate() async {
    setState(() {
      isLoading = true;
    });
    String facemaskPic, aboutPic, memePic, bestPic;
    facemaskPic = await _uploadFacemaskImage(image: _faceImage);
    aboutPic = await _uploadAboutImage(image: aboutImage);
    memePic = await _uploadMemeImage(image: memeImage);
    bestPic = await _uploadBestImage(image: bestImage);
    FirebaseFirestore.instance.collection("User").doc(userUid).update(
      {
        "UserAboutPic": aboutPic,
        "UserBestPic": bestPic,
        "UserFacemaskPic": facemaskPic,
        "UserMemePic": memePic,
      },
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomePage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<void> myDialogBox({Function functionFirst, Function functionLast}) {
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
                  onTap: functionFirst,
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Pick Form Gallery"),
                  onTap: functionLast,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void vaildation() {
    if (_faceImage == null &&
        bestImage == null &&
        memeImage == null &&
        bestImage == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Photo Are Empty"),
        ),
      );
    } else if (_faceImage == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" FacemaskPhoto Is Empty"),
        ),
      );
    } else if (aboutImage == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" AboutPhoto Is Empty"),
        ),
      );
    } else if (memeImage == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" MemePhoto Is Empty"),
        ),
      );
    } else if (bestImage == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" BestPhoto Are Empty"),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 130,
                    child: Image(image: AssetImage("images/logo.png")),
                  ),
                  Text(
                    "UPLOAD YOUR",
                    style: TextStyle(
                        color: Color(0xff1a214f),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "PIC!",
                    style: TextStyle(
                      color: Color(0xff1a214f),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 420,
              width: 350,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            myDialogBox(
                              functionLast: () {
                                getFaceImage(source: ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                              functionFirst: () {
                                getFaceImage(source: ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          child: _buildSinglePictureProduct(image: _faceImage),
                        ),
                        Text(
                          "FACEMASK PIC",
                          style: TextStyle(
                            color: Color(0xff1a214f),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: GestureDetector(
                              onTap: () {
                                myDialogBox(
                                  functionLast: () {
                                    getAboutImage(source: ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                  functionFirst: () {
                                    getAboutImage(source: ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                              child:
                                  _buildSinglePictureProduct(image: aboutImage),
                            ),
                          ),
                          Text(
                            "A PIC THAT ABOUT YOU",
                            style: TextStyle(
                              color: Color(0xff1a214f),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: GestureDetector(
                                onTap: () {
                                  myDialogBox(
                                    functionLast: () {
                                      getMemeImage(source: ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                    functionFirst: () {
                                      getMemeImage(source: ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child: _buildSinglePictureProduct(
                                  image: memeImage,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "YOUR MEME TASTE",
                              style: TextStyle(
                                color: Color(0xff1a214f),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () {
                        myDialogBox(
                          functionLast: () {
                            getBestImage(source: ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                          functionFirst: () {
                            getBestImage(source: ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      child: _buildSinglePictureProduct(image: bestImage),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "YOUR BEST PIC",
                      style: TextStyle(
                        color: Color(0xff1a214f),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: isLoading == false
                  ? MyButton(
                      onPressed: () {
                        vaildation();
                      },
                    )
                  : CircularProgressIndicator(),
            ),
            Center(
              child: RowSlider(
                first: false,
                second: false,
                third: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
