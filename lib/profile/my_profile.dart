import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfileScreen extends StatefulWidget {
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;

  var _authToken, _id;
  String _name,
      _avatarUrl,
      _email,
      _bio,
      _url,
      _company,
      _location,
      _occupation,
      _phone,
      _birthDate;

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
    String email = _sharedPreferences.getString(AuthUtils.emailKey);
    String bio = _sharedPreferences.getString(AuthUtils.bioKey);
    String url = _sharedPreferences.getString(AuthUtils.urlKey);
    String company = _sharedPreferences.getString(AuthUtils.companyKey);
    String location = _sharedPreferences.getString(AuthUtils.locationKey);
    String occupation = _sharedPreferences.getString(AuthUtils.occupationKey);
    String phone = _sharedPreferences.getString(AuthUtils.phoneKey);
    String birthDate = _sharedPreferences.getString(AuthUtils.birthDateKey);

    print(authToken);

    setState(() {
      _authToken = authToken;
      _id = id;
      _name = name;
      _avatarUrl = avatarUrl;
      _email = email;
      _bio = bio;
      _url = url;
      _company = company;
      _location = location;
      _occupation = occupation;
      _phone = phone;
      _birthDate = birthDate;
    });
  }

  //Call Phone
  _callPhone(String url) async {
    //const url = linkUrl;
    if (await canLaunch(_phone)) {
      await launch(_phone);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Column1
  Widget profileColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: _name,
              subtitle: _occupation,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat),
                  color: buttonColor,
                  onPressed: () {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: new Text('Messaging Coming Soon!'),
                    ));
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: buttonColor,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_avatarUrl ??
                        'https://m.africoders.com/media/users/default.png'),
                    foregroundColor: Colors.white,
                    radius: 40.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  color: buttonColor,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      );

  //column3
  Widget descColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              _bio.isEmpty ? 'No Bio..' : _bio ?? 'Loading..',
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Color(0xFFFEFEFE)),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );

  //column4
  Widget accountColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Website",
                  subtitle: _url,
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: _phone,
                ),
                ProfileTile(
                  title: "Company",
                  subtitle: _company,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Location",
                  subtitle: _location,
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: _email,
                ),
                ProfileTile(
                  title: "Birth Date",
                  subtitle: birthDateFormatter(_birthDate),
                ),
              ],
            ),
          ],
        ),
      );

  Widget followColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ProfileTile(
              title: "0",
              subtitle: "Posts",
            ),
            ProfileTile(
              title: "0",
              subtitle: "Followers",
            ),
            ProfileTile(
              title: "0",
              subtitle: "Comments",
            ),
            ProfileTile(
              title: "0",
              subtitle: "Following",
            )
          ],
        ),
      );

  String birthDateFormatter(String dateTimeString) {
    var dateTime = DateTime.parse(dateTimeString);
    var formatter = new DateFormat('d, MMMM');
    //var formatter = new DateFormat('E, d MMM, y ').add_jm();
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: buildAppBar(context),
      key: _scaffoldKey,
      backgroundColor: mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            profileColumn(deviceSize),
            listDivider(),
            followColumn(deviceSize),
            listDivider(),
            descColumn(deviceSize),
            listDivider(),
            accountColumn(deviceSize)
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title.isEmpty ? 'NIL' : title ?? 'Loading...',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w500, color: buttonColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle.isEmpty ? 'NIL' : subtitle ?? 'Loading..',
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFFFEFEFE)),
        ),
      ],
    );
  }
}
