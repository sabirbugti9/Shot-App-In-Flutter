import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/widgets/myButton.dart';
import 'package:shot_app/widgets/row_silder.dart';
import 'package:shot_app/screens/interest_screen.dart';
import 'package:shot_app/widgets/toplogo_and_title.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();

  final TextEditingController userName = TextEditingController();

  final TextEditingController age = TextEditingController();

  final TextEditingController major = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController somethingAbout = TextEditingController();

  final TextEditingController whatAreYou = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool obscureText = true;
  bool isPasswordFlied = false;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);
  bool isMale = true;
  bool isLoading = false;
  void submit() async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
    FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
      "UserName": userName.text,
      "UserId": result.user.uid,
      "UserAge": age.text,
      "UserMajor": major.text,
      "UserInterest": "Tiktok",
      "UserFacemaskPic":
          "https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png",
      "UserBestPic":
          "https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png",
      "UserAboutPic":
          "https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png",
      "UserMemePic":
          "https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png",
      "UserGender": isMale == true ? "Male" : "Female",
      "UserEmail": email.text,
      "UserSomethingAbout": somethingAbout.text,
      "UserYouLooking": whatAreYou.text,
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => InterestScreen(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  void vaildation() async {
    if (userName.text.isEmpty &&
        age.text.isEmpty &&
        major.text.isEmpty &&
        email.text.isEmpty &&
        somethingAbout.text.isEmpty &&
        whatAreYou.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (userName.text.length < 6) {
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
    } else if (int.parse(age.text) > 40 || int.parse(age.text) <=0) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Age Must Be > 0 And < 40 "),
        ),
      );
    }  else if (email.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (somethingAbout.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("About YourSelf Flied Is Empty "),
        ),
      );
    } else if (whatAreYou.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("You Looking Flied Is Empty "),
        ),
      );
    } else {
      submit();
    }
  }

  Widget _buildSingleTextFormFiled({
    String name,
    bool secondText,
    String subName,
    TextInputType keyBoard,
    double height,
    bool isPasswordFlied = false,
    TextEditingController controller,
  }) {
    return Container(
      height: 55,
      width: 345,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff1a214f),
                ),
              ),
              secondText == true
                  ? Text(
                      subName,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff1a214f),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            height: height,
            width: 180,
            child: isPasswordFlied == false
                ? TextFormField(
                    keyboardType: keyBoard,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                        ),
                      ),
                    ),
                  )
                : TextFormField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormFleid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        _buildSingleTextFormFiled(
          name: "Name",
          controller: userName,
          secondText: false,
          height: 40,
        ),
        _buildSingleTextFormFiled(
          name: "AGE",
          keyBoard: TextInputType.phone,
          secondText: false,
          controller: age,
          height: 40,
        ),
        _buildSingleTextFormFiled(
          name: "Major",
          controller: major,
          secondText: false,
          height: 40,
        ),
        Container(
          padding: EdgeInsets.only(right: 67),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff1a214f),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = !isMale;
                  });
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 10),
                  width: 180,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0)),
                  child: Center(
                    child: Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildSingleTextFormFiled(
          name: "Email",
          secondText: false,
          controller: email,
          height: 80,
        ),
        _buildSingleTextFormFiled(
          name: "Password",
          secondText: false,
          controller: password,
          isPasswordFlied: true,
          height: 40,
        ),
        _buildSingleTextFormFiled(
          name: "Something",
          secondText: true,
          controller: somethingAbout,
          subName: "About YourSelf",
          height: 100,
        ),
        _buildSingleTextFormFiled(
          name: "What Are You",
          controller: whatAreYou,
          secondText: true,
          subName: "looking for",
          height: 40,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopLogoAndTitle(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 480,
              child: ListView(
                children: [
                  _buildTextFormFleid(),
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
                first: true,
                second: false,
                third: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
