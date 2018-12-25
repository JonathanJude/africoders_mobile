import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/model/linkShareModel.dart';
import 'package:africoders_mobile/repo/jobAdRepo.dart';
import 'package:africoders_mobile/repo/linkShareRepo.dart';
import 'package:africoders_mobile/screens/job_ads/job_list.dart';
import 'package:africoders_mobile/screens/job_ads/place_job_ad.dart';
import 'package:africoders_mobile/screens/link/job_list.dart';
import 'package:africoders_mobile/screens/link/share_a_link.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LinkHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(context: context),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<LinkShare>>(
        future: fetchLinkShareWithNoComments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? LinkList(links: snapshot.data)
              : Center(
                  child: AfricodersLoader(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0xFF547A7D),
        ),
        backgroundColor: Color(0xFF9CE0AD),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new ShareALink();
          }));
        },
      ),
    );
  }
}