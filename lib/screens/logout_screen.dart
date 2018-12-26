import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/screens/login.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1200));

    Future<Widget> loading() async {}
    return Scaffold(
      backgroundColor: mainBgColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AfricodersLoader(),
            Text('Logging Out', style: TextStyle(color: buttonColor))
          ],
        ),
      ),
    );
  }
}
