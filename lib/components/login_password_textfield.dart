import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isObscured;
  final Color eyeButtonColor;
  final VoidCallback togglePassword;
  final String passwordError;

  LoginPasswordTextField(
      {this.isObscured,
      this.eyeButtonColor,
      this.passwordController,
      this.togglePassword,
      this.passwordError});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: passwordController,
        style: TextStyle(
          color: Color(0xFF9CE0AD),
        ),
        obscureText: isObscured,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          focusedBorder: textFieldBorder,
          enabledBorder: textFieldBorder,
          border: textFieldBorder,
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFF9CE0AD),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Color(0xFF9CE0AD)),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye, color: eyeButtonColor),
              onPressed: togglePassword
              /* () {
              if (isObscured) {
                setState(() {
                  isObscured = false;
                  eyeButtonColor = Colors.grey;
                });
              } else {
                setState(() {
                  isObscured = true;
                  eyeButtonColor = Color(0xFF9CE0AD);
                });
              }
            }, */
              ),
        ),
      ),
    );
  }
}
