import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PlaceJobADButton extends StatelessWidget {
  final VoidCallback onPressed;
  PlaceJobADButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: largeClickButton(
            text: 'Place Job AD', onPressed: onPressed, iconExists: false),
      ),
    );
  }
}
