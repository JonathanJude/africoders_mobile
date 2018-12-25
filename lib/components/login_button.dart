import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  LoginButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: largeClickButton(
            text: 'LOGIN', onPressed: onPressed, iconExists: false),
      ),
    );
  }
}
