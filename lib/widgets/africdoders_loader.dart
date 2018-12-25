import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:africoders_mobile/colors.dart';

class AfricodersLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: primaryTextColor,
      size: 70.0,
    );
  }
}
