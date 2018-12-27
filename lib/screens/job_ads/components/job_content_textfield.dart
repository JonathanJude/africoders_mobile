import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class JobContentTextField extends StatelessWidget {
  final TextEditingController textController;
  final String textError;
  JobContentTextField({this.textController, this.textError});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        maxLines: 5,
        controller: textController,
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
              Icons.description,
              color: Color(0xFF9CE0AD),
            ),
            labelText: 'Job Description',
            labelStyle: TextStyle(color: Color(0xFF9CE0AD))),
      ),
    );
  }
}
