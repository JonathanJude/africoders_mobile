import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/model/jobAdModel.dart';
import 'package:africoders_mobile/repo/jobAdRepo.dart';
import 'package:africoders_mobile/screens/job_ads/job_list.dart';
import 'package:africoders_mobile/screens/job_ads/place_job_ad.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(context: context),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: FutureBuilder<List<JobAd>>(
        future: fetchJobAdWithNoComments(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? JobList(jobs: snapshot.data)
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
            return new PlaceJobAd();
          }));
        },
      ),
    );
  }
}
