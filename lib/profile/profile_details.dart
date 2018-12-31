import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:africoders_mobile/model/userProfileModel.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:africoders_mobile/colors.dart';

class ProfileDetails extends StatefulWidget {
  final UserProfile details;

  ProfileDetails({this.details});

  @override
  ProfileDetailsState createState() {
    return new ProfileDetailsState();
  }
}

class ProfileDetailsState extends State<ProfileDetails> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;

  var _id;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    var id = _sharedPreferences.getInt(AuthUtils.userIdKey);

    setState(() {
      _id = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      endDrawer: AppDrawer(context: context),
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
      floatingActionButton: _id != widget.details.id
          ? FloatingActionButton(
              onPressed: () {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text(
                      'You can Follow ${widget.details.name} very Soon!'),
                ));
              },
              backgroundColor: Color(0xFF9CE0AD),
              child: Icon(
                Icons.person_add,
                color: Color(0xFF547A7D),
              ),
            )
          : SizedBox(),
    );
  }

  Widget profileColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: widget.details.first.isEmpty
                  ? widget.details.name
                  : widget.details.first +
                      ' ' +
                      widget.details.last +
                      ' (' +
                      widget.details.name +
                      ') ',
              subtitle: widget.details.occupation,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _id != widget.details.id
                    ? IconButton(
                        icon: Icon(Icons.chat),
                        color: buttonColor,
                        onPressed: () {
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                            content: new Text('Messaging Coming Soon!'),
                          ));
                        },
                      )
                    : SizedBox(),
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
                    backgroundImage: NetworkImage(widget.details.avatarUrl ??
                        'https://m.africoders.com/media/users/default.png'),
                    foregroundColor: Colors.white,
                    radius: 40.0,
                  ),
                ),
                _id != widget.details.id
                    ? IconButton(
                        icon: Icon(Icons.call),
                        color: buttonColor,
                        onPressed: () {},
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      );

  Widget descColumn(Size deviceSize) => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              widget.details.bio.isEmpty
                  ? 'No Bio..'
                  : parseHtmlString(widget.details.bio) ?? 'Loading..',
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Color(0xFFFEFEFE)),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );

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
                  subtitle: widget.details.url,
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: widget.details.phone,
                ),
                ProfileTile(
                  title: "Company",
                  subtitle: widget.details.company,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Location",
                  subtitle: widget.details.location,
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: "userEmail here",
                ),
                ProfileTile(
                  title: "Birth Date",
                  subtitle: birthDateFormatter(widget.details.birthdate),
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
