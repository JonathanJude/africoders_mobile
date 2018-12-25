import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LinkURLTextField extends StatelessWidget {
  final TextEditingController urlController;
  final String urlError;
  LinkURLTextField({this.urlController, this.urlError});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: urlController,
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
            labelText: 'Link Address',
            labelStyle: TextStyle(color: Color(0xFF9CE0AD))),
      ),
    );
  }
}
