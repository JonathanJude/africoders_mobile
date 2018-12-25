import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ShareLinkButton extends StatelessWidget {
  final VoidCallback onPressed;
  ShareLinkButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: largeClickButton(
            text: 'Share Link', onPressed: onPressed, iconExists: false),
      ),
    );
  }
}
