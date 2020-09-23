import 'package:flutter/material.dart';
import 'package:shot_app/const/my_gradient.dart';
import 'package:shot_app/screens/sign_in.dart';
import 'package:shot_app/screens/signup.dart';

class WelcomeLancers extends StatelessWidget {
  Widget _buildSingleGender({String name}) {
    return Container(
      height: 80,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(
        width: 2,
        color: Color(0xff1a214f),
      )),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xff1a214f),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
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
                      "WELCOME",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff1a214f),
                      ),
                    ),
                    Text(
                      "LANCERS",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff1a214f),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 320,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildSingleGender(name: "MALE"),
                  SizedBox(
                    height: 40,
                  ),
                  _buildSingleGender(name: "FEMALE"),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Already Been Shooting",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff1a214f),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => SignIn(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => SignUp(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
