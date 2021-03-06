import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/profile/my_profile.dart';
import 'package:flutter/services.dart';
import 'package:africoders_mobile/screens/login.dart';
import 'package:africoders_mobile/screens/signup_successful.dart';
import 'package:flutter/material.dart';
import 'package:africoders_mobile/auth/auth.dart';

void main() async {
  ///
  /// Force the layout to Portrait mode
  ///
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(new AfricodersMobile());
}

class AfricodersMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Raleway'),
      home: LoginPage(),
      //home: MyProfileScreen(),
    );
  }
}
