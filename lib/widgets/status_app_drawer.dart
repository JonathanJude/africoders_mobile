import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/profile/my_profile.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/utils/network_util.dart';
import 'package:africoders_mobile/widgets/custom_badge.dart';
import 'package:africoders_mobile/widgets/drawers/home_drawer.dart';
import 'package:africoders_mobile/widgets/drawers/status_home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusAppDrawer extends StatefulWidget {
  //final BuildContext context;
  //StatusAppDrawer({@required this.context});
  @override
  StatusAppDrawerState createState() {
    return new StatusAppDrawerState();
  }
}

class StatusAppDrawerState extends State<StatusAppDrawer> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;

  var _authToken, _id, _name, _avatarUrl;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    String name = _sharedPreferences.getString(AuthUtils.nameKey);
    String avatarUrl = _sharedPreferences.getString(AuthUtils.avatarUrlKey);

    print(authToken);

    setState(() {
      _authToken = authToken;
      _id = id;
      _name = name;
      _avatarUrl = avatarUrl;
    });

    /* if (_authToken == null) {
      _logout();
    } */
  }

  /*  _logout() {
    NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
  } */
  _logout(BuildContext context) {
    NetworkUtils.logoutUser(context, _sharedPreferences);
  }

  /*  _logoutContext(BuildContext context) {
    NetworkUtils.logoutUser(context, _sharedPreferences);
  } */

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: mainBgColor,
        //padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          children: <Widget>[
            //Image & Menu Button
            buildDrawerHeader(context, _avatarUrl, _name),
            StatusHomeDrawer()
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader(
      BuildContext context, String avatarUrl, String name) {
    return Container(
      //color: drawerHeaderBgColor,
      color: mainBgColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_white.png',
                  height: 60.0,
                  width: 100.0,
                ),
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 25.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new MyProfileScreen();
              }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    child: Image.network(
                      avatarUrl ??
                          'https://m.africoders.com/media/users/default.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name ?? "UserName",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: buttonColor),
                    ),
                    Text(
                      'View Profile',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w200,
                          color: Color(0xFFFEFEFE)),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                Icons.message,
                color: buttonColor,
              ),
              BadgeIconButton(
                icon: Icon(MdiIcons.information, color: buttonColor),
                onPressed: () {},
                badgeColor: Colors.red,
                itemCount: 1,
              ),
              Icon(
                Icons.settings,
                color: buttonColor,
              ),
              IconButton(
                icon: Icon(MdiIcons.logout),
                onPressed: () => _logout,
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
