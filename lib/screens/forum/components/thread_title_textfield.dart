import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ThreadTitleTextField extends StatelessWidget {
  final TextEditingController titleController;
  final String titleError;
  ThreadTitleTextField({this.titleController, this.titleError});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: titleController,
        style: TextStyle(
          color: Color(0xFF9CE0AD),
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            focusedBorder: textFieldBorder,
            enabledBorder: textFieldBorder,
            border: textFieldBorder,
            prefixIcon: Icon(
              Icons.mail,
              color: Color(0xFF9CE0AD),
            ),
            labelText: 'Thread Title',
            labelStyle: TextStyle(color: Color(0xFF9CE0AD))),
      ),
    );
  }
}
