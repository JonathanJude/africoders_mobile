import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CreateBlogButton extends StatelessWidget {
  final VoidCallback onPressed;
  CreateBlogButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: largeClickButton(
            text: 'Create Blog', onPressed: onPressed, iconExists: false),
      ),
    );
  }
}
