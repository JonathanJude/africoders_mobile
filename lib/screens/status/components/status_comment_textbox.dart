import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatusCommentTextField extends StatelessWidget {
  final TextEditingController commentController;
  final VoidCallback onPressed;
  StatusCommentTextField({this.commentController, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: TextField(
              autocorrect: true,
              controller: commentController,
              style: TextStyle(color: Color(0xFF9CE0AD), fontSize: 15.0),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                focusedBorder: textFieldBorder,
                enabledBorder: textFieldBorder,
                border: textFieldBorder,
                /* prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF9CE0AD),
                ), */
                hintText: 'Write a comment...',
                hintStyle: TextStyle(
                  color: buttonColor,
                )
                    /* labelText: 'User Name',
                  labelStyle: TextStyle(color: Color(0xFF9CE0AD),) */
                    ,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: clickButton(
                iconExists: false, text: 'Reply', onPressed: onPressed),
          )
        ],
      ),
    );
  }
}
