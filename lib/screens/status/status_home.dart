import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/repo/statusRepo.dart';
import 'package:africoders_mobile/model/statusModel.dart';
import 'package:africoders_mobile/screens/status/status_list.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/status_app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatusHome extends StatefulWidget {
  _StatusHomeState createState() => _StatusHomeState();
}

class _StatusHomeState extends State<StatusHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Handling user Authentication Token
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
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: StatusAppDrawer(),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<StatusModel>>(
        future: fetchStatusComments(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? StatusList(statuses: snapshot.data, currentUserId: _id)
              : Center(
                  //child: AfricodersLoader(),
                  child: AfricodersLoader(),
                );
        },
      ),
    );
  }
}
