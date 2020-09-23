import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grid_selector/base_grid_selector_item.dart';
import 'package:grid_selector/grid_selector.dart';

import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/screens/home_page.dart';
import 'package:shot_app/screens/upload_image.dart';

import 'package:shot_app/widgets/myButton.dart';
import 'package:shot_app/widgets/row_silder.dart';

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  Widget _buildTopPart() {
    return Container(
      height: 280,
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
              "So...What are you into?",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Color(0xff1a214f),
              ),
            ),
            Text(
              "[INTERESTS]",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xff1a214f),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getmyInterest() {
    if (selected == 1) {
      setState(() {
        myInterest = "El Monte";
      });
    } else if (selected == 2) {
      setState(() {
        myInterest = "MOVIES";
      });
    } else if (selected == 3) {
      setState(() {
        myInterest = "BEACHES";
      });
    } else if (selected == 4) {
      setState(() {
        myInterest = "BOBA";
      });
    } else if (selected == 5) {
      setState(() {
        myInterest = "COMEDY";
      });
    } else if (selected == 6) {
      setState(() {
        myInterest = "MEME";
      });
    } else if (selected == 7) {
      setState(() {
        myInterest = "BASKETBALL";
      });
    } else if (selected == 8) {
      setState(() {
        myInterest = "FOOTBALL";
      });
    } else if (selected == 9) {
      setState(() {
        myInterest = "TENNIS";
      });
    } else if (selected == 10) {
      setState(() {
        myInterest = "HORROR";
      });
    } else if (selected == 11) {
      setState(() {
        myInterest = "TACOS";
      });
    } else if (selected == 12) {
      setState(() {
        myInterest = "NETFLIX";
      });
    } else if (selected == 13) {
      setState(() {
        myInterest = "COOKING";
      });
    } else if (selected == 14) {
      setState(() {
        myInterest = "THE BIBLE";
      });
    } else if (selected == 15) {
      setState(() {
        myInterest = "ANIMAL CROSSING";
      });
    } else if (selected == 16) {
      setState(() {
        myInterest = "ADVOCADO TOAST";
      });
    } else if (selected == 17) {
      setState(() {
        myInterest = "DAILY BREW";
      });
    } else if (selected == 18) {
      setState(() {
        myInterest = "LATENIGHT TACO BELL RUNS";
      });
    } else if (selected == 19) {
      setState(() {
        myInterest = "CHICK FIL A COOKIES";
      });
    } else if (selected == 20) {
      setState(() {
        myInterest = "ENNEAGRAM";
      });
    } else if (selected == 21) {
      setState(() {
        myInterest = "TIK TOK";
      });
    } else if (selected == 22) {
      setState(() {
        myInterest = "TRUMP";
      });
    } else if (selected == 23) {
      setState(() {
        myInterest = "HARRY STYLE";
      });
    } else if (selected == 24) {
      setState(() {
        myInterest = "SHOPPING ON AMAZON";
      });
    } else if (selected == 25) {
      setState(() {
        myInterest = "COUNTRY MUSIC";
      });
    } else if (selected == 26) {
      setState(() {
        myInterest = "HIKING";
      });
    } else if (selected == 27) {
      setState(() {
        myInterest = "CHURCH";
      });
    } else if (selected == 28) {
      setState(() {
        myInterest = "WANDAS";
      });
    } else if (selected == 29) {
      setState(() {
        myInterest = "DRIVE IN THEATRE";
      });
    } else if (selected == 30) {
      setState(() {
        myInterest = "CBU EVENTS";
      });
    } else if (selected == 31) {
      setState(() {
        myInterest = "THE REC";
      });
    } else if (selected == 32) {
      setState(() {
        myInterest = "DISNEYLAND";
      });
    } else if (selected == 33) {
      setState(() {
        myInterest = "HOOKING UP";
      });
    } else if (selected == 34) {
      setState(() {
        myInterest = "CROCS";
      });
    } else if (selected == 35) {
      setState(() {
        myInterest = "BRISCOS";
      });
    } else if (selected == 36) {
      setState(() {
        myInterest = "HILLSONG";
      });
    } else if (selected == 37) {
      setState(() {
        myInterest = "BREAKING VISITING HOURS";
      });
    } else if (selected == 38) {
      setState(() {
        myInterest = "PAUL BROTHERS";
      });
    } else if (selected == 39) {
      setState(() {
        myInterest = "QUARANTINE AND CHILL?";
      });
    }
  }

  List<BaseGridSelectorItem> _getTails() {
    return [
      BaseGridSelectorItem(key: 1, label: "El Monte"),
      BaseGridSelectorItem(key: 2, label: "MOVIES"),
      BaseGridSelectorItem(key: 3, label: "BEACHES"),
      BaseGridSelectorItem(key: 4, label: "BOBA"),
      BaseGridSelectorItem(key: 5, label: "COMEDY"),
      BaseGridSelectorItem(key: 6, label: "MEME"),
      BaseGridSelectorItem(key: 7, label: "BASKETBALL"),
      BaseGridSelectorItem(key: 8, label: "FOOTBALL"),
      BaseGridSelectorItem(key: 9, label: "TENNIS"),
      BaseGridSelectorItem(key: 10, label: "HORROR"),
      BaseGridSelectorItem(key: 11, label: "TACOS"),
      BaseGridSelectorItem(key: 12, label: "NETFLIX"),
      BaseGridSelectorItem(key: 13, label: "COOKING"),
      BaseGridSelectorItem(key: 14, label: "THE BIBLE"),
      BaseGridSelectorItem(key: 15, label: "ANIMAL CROSSING"),
      BaseGridSelectorItem(key: 16, label: "ADVOCADO TOAST"),
      BaseGridSelectorItem(key: 17, label: "DAILY BREW"),
      BaseGridSelectorItem(key: 18, label: "LATENIGHT TACO BELL RUNS"),
      BaseGridSelectorItem(key: 19, label: "CHICK FIL A COOKIES"),
      BaseGridSelectorItem(key: 20, label: "ENNEAGRAM"),
      BaseGridSelectorItem(key: 21, label: "TIK TOK"),
      BaseGridSelectorItem(key: 22, label: "TRUMP"),
      BaseGridSelectorItem(key: 23, label: "HARRY STYLE"),
      BaseGridSelectorItem(key: 24, label: "SHOPPING ON AMAZON"),
      BaseGridSelectorItem(key: 25, label: "COUNTRY MUSIC"),
      BaseGridSelectorItem(key: 26, label: "HIKING"),
      BaseGridSelectorItem(key: 27, label: "CHURCH"),
      BaseGridSelectorItem(key: 28, label: "WANDAS"),
      BaseGridSelectorItem(key: 29, label: "DRIVE IN THEATRE"),
      BaseGridSelectorItem(key: 30, label: "CBU EVENTS"),
      BaseGridSelectorItem(key: 31, label: "THE REC"),
      BaseGridSelectorItem(key: 32, label: "DISNEYLAND"),
      BaseGridSelectorItem(key: 33, label: "HOOKING UP"),
      BaseGridSelectorItem(key: 34, label: "CROCS"),
      BaseGridSelectorItem(key: 35, label: "BRISCOS"),
      BaseGridSelectorItem(key: 36, label: "HILLSONG"),
      BaseGridSelectorItem(key: 37, label: "BREAKING VISITING HOURS"),
      BaseGridSelectorItem(key: 38, label: "PAUL BROTHERS"),
      BaseGridSelectorItem(key: 39, label: "QUARANTINE AND CHILL?"),
    ];
  }

  bool isLoading = false;
  int selected = 1;
  String myInterest;
  void addInsterestInFirebase() {
    setState(() {
      isLoading = true;
    });
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("User").doc(user.uid).update({
      "UserInterest": myInterest,
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => UploadImage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        decoration: BoxDecoration(gradient: myGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTopPart(),
            Container(
              height: 400,
              child: ListView(
                children: [
                  GridSelector<int>(
                    backgroundColor: Color(0xff1a214f),
                    selectedItemKey: 1,
                    itemTextFontSize: 10,
                    itemTextColor: Colors.white,
                    title: "",
                    items: _getTails(),
                    onSelectionChanged: (select) {
                      setState(() {
                        selected = select;
                      });
                    },
                    itemSize: 65,
                  ),
                ],
              ),
            ),
            Center(
              child: isLoading == false
                  ? MyButton(
                      onPressed: () {
                        getmyInterest();
                        addInsterestInFirebase();
                      },
                    )
                  : CircularProgressIndicator(),
            ),
            Center(
              child: RowSlider(
                first: false,
                second: true,
                third: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
