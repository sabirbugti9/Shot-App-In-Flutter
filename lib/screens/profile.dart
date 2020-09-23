import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/screens/home_page.dart';
import 'package:shot_app/screens/info_edit.dart';
import 'package:shot_app/screens/welcome_lancers.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String image, firstImage, secondImage, thridImage;

  String name;
  User user;
  String somethingAbout;
  Widget singleImageContainer({String image}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
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
        appBar: AppBar(
          leading: Container(
            height: 50,
            child: Image(
              color: Colors.cyan,
              image: AssetImage("images/mail.png"),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Container(
            height: 60,
            child: Container(
              height: 60,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage("images/logo.png"),
              ),
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("User").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var myDoc = snapshot.data.docs;
            myDoc.forEach((checkDocs) {
              if (checkDocs.data()["UserId"] == user.uid) {
                image = checkDocs.data()["UserFacemaskPic"];
                name = checkDocs.data()["UserName"];
                firstImage = checkDocs.data()["UserAboutPic"];
                secondImage = checkDocs.data()["UserMemePic"];
                thridImage = checkDocs.data()["UserBestPic"];
                somethingAbout = checkDocs.data()["UserSomethingAbout"];
              }
            });
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: myGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 320,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                image,
                              ),
                              radius: 65,
                              backgroundColor: Colors.yellow[900],
                            ),
                          ],
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.blueGrey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          somethingAbout,
                          style: TextStyle(
                              color: Colors.blueGrey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => InfoEdit(),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'EDIT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'INFO',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'PROFILE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'VERIFICATION',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 360,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        singleImageContainer(
                          image: firstImage,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        singleImageContainer(
                          image: secondImage,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        singleImageContainer(
                          image: thridImage,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => WelcomeLancers(),
                              ),
                            );
                          },
                          child: Text(
                            'SIGN OUT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await user.delete();
                            await FirebaseFirestore.instance
                                .collection("User")
                                .doc(user.uid)
                                .delete();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => WelcomeLancers(),
                              ),
                            );
                          },
                          child: Text(
                            'DELETE ACCOUNT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
