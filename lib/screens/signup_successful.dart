import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/screens/login.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUpSuccess extends StatelessWidget {
  final String userName;
  SignUpSuccess({this.userName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainBgColor,
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            SizedBox(height: size.height / 4),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 120.0,
                    child: Image.asset(
                      'assets/images/success.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Hello $userName, You have successfully signed up on Africoders.com! \n Explore and join discussions with other African developers!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  largeClickButton(
                      iconExists: false,
                      text: 'LOGIN',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                          return new LoginPage();
                        }));
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
