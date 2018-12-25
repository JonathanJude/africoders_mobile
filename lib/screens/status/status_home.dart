import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/repo/statusRepo.dart';
import 'package:africoders_mobile/model/statusModel.dart';
import 'package:africoders_mobile/screens/status/status_list.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/status_app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatusHome extends StatefulWidget {
  _StatusHomeState createState() => _StatusHomeState();
}

class _StatusHomeState extends State<StatusHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: StatusAppDrawer(context: context),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<StatusModel>>(
        future: fetchStatusComments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? StatusList(statuses: snapshot.data)
              : Center(
                  //child: AfricodersLoader(),
                  child: AfricodersLoader(),
                );
        },
      ),
    );
  }
}
