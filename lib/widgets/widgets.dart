import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/profile/user_profile.dart';
import 'package:flutter/material.dart';

Widget africodersUserName(
    {@required BuildContext context,
    @required int userId,
    @required String userName}) {
  return FlatButton(
    child: Text(userName,
        style: TextStyle(
            //color: Color(0xFFFEFEFE),
            color: Color(0xFF54797F),
            fontSize: 14.0,
            fontWeight: FontWeight.w800)),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new UserProfileScreen(
          userId: userId,
        );
      }));
    },
  );
}

Widget listDivider() => Divider(
      color: dividerColor,
      height: 1.0,
    );

Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: mainBgColor,
    centerTitle: true,
    title: Image.asset(
      'assets/images/logo_white.png',
      height: 50.0,
      width: 100.0,
    ),
    actions: <Widget>[
      Builder(
        builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
      ),
      /*  child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ), */
    ],
  );
}

Widget clickButton(
    {String text, Function onPressed, bool iconExists, IconData icon}) {
  return RawMaterialButton(
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    onPressed: onPressed,
    padding: EdgeInsets.all(2.0),
    fillColor: Color(0xFF9CE0AD),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        iconExists ? Icon(icon) : SizedBox(),
        Text(
          text,
          style: TextStyle(
              color: Color(0xFF547A7D),
              fontSize: 13.0,
              fontWeight: FontWeight.w800),
        )
      ],
    ),
  );
}

Widget largeClickButton(
    {String text, VoidCallback onPressed, bool iconExists, IconData icon}) {
  return RawMaterialButton(
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    onPressed: onPressed,
    padding: EdgeInsets.all(2.0),
    fillColor: Color(0xFF9CE0AD),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        iconExists ? Icon(icon) : SizedBox(),
        Expanded(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Color(0xFF547A7D),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
        )
      ],
    ),
  );
}

final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
        color: Color(0xFF9CE0AD), style: BorderStyle.solid, width: 0.80));
