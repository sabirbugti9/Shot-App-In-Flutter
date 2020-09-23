import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shot_app/chat/chat_screen.dart';
import 'package:shot_app/model/usermodel.dart';
import 'package:shot_app/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel;

  bool swipe = false;

  Widget _shootBall() {
    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/Ball.png',
                ),
              ),
            ),
          ),
          Text(
            'SHOOT!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomPart({@required images, @required text}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 50,
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  images,
                ),
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget _swipe() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Color(0xff876412),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userModel.userName},${userModel.userAge}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userWhatAbout,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userSomeThing,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _swipefalse() {
    return Container(
      height: 400,
      width: double.infinity,
      color: Color(0xff876412),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userModel.userName},${userModel.userAge}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userWhatAbout,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userSomeThing,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userGender,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userEmail,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
            Text(
              userModel.userInterest,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff03234a),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("User").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            snapshot.data.docs.forEach((check) {
              if (check.data()["UserId"] == currentUser.uid) {
                userModel = UserModel(
                  userMajor: check.data()["UserMajor"],
                  userAge: check.data()["UserAge"],
                  userInterest: check.data()["UserInterest"],
                  userSomeThing: check.data()["UserSomethingAbout"],
                  userWhatAbout: check.data()["UserYouLooking"],
                  userImage: check.data()["UserFacemaskPic"],
                  userEmail: check.data()["UserEmail"],
                  userGender: check.data()["UserGender"],
                  userName: check.data()["UserName"],
                );
              }
            });

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => ChatScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 70,
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image:
                                                AssetImage("images/mail.png"),
                                          ),
                                        ),
                                      ),
                                      Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Text(
                                            'SHOTS',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'MADE',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('images/logo.png'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => Profile(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.alarm,
                              size: 50,
                              color: Color(0xff2e78be),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userModel.userImage,
                          ),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    swipe = !swipe;
                                  });
                                },
                                child:
                                    swipe == false ? _swipe() : _swipefalse(),
                              ),
                              Container(
                                height: 120,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Color(0xff03234a),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _bottomPart(
                                        images: 'images/bestpng.png',
                                        text: 'EXILE'),
                                    _bottomPart(
                                        images: 'images/fire.png',
                                        text: 'SUPER')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _shootBall(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
