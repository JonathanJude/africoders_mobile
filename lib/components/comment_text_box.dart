import 'package:flutter/material.dart';

class CommentTextBox extends StatelessWidget {
  final TextEditingController commentTextController;
  final VoidCallback onPressed;
  final bool showSendButton;
  CommentTextBox({
    @required this.commentTextController,
    @required this.onPressed,
    this.showSendButton,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(7.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Material(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                  autocorrect: true,
                  //autofocus: true,
                  cursorColor: Color(0xFF527980),
                  controller: commentTextController,
                  decoration: InputDecoration(
                      hintText: 'Write a comment..',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Color(0xFF527980),
                              width: 1.0,
                              style: BorderStyle.solid)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.75,
                              style: BorderStyle.solid))),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: FloatingActionButton(
              backgroundColor: Color(0xFF527980),
              onPressed: onPressed,
              child: Icon(
                Icons.send,
                //color: Color(0xFF527980),
              ),
            ),
          )
        ],
      ),
    );
  }
}
