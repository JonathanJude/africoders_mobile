import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignUpNameTextField extends StatelessWidget {
  final TextEditingController nameController;
  final String nameError;
  SignUpNameTextField({this.nameController, this.nameError});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: nameController,
        style: TextStyle(
          color: Color(0xFF9CE0AD),
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            focusedBorder: textFieldBorder,
            enabledBorder: textFieldBorder,
            border: textFieldBorder,
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xFF9CE0AD),
            ),
            labelText: 'User Name',
            labelStyle: TextStyle(color: Color(0xFF9CE0AD))),
      ),
    );
  }
}
