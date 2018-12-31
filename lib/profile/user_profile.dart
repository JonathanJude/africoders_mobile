import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/repo/userProfileRepo.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:africoders_mobile/profile/profile_details.dart';

class UserProfileScreen extends StatefulWidget {
  final int userId;
  UserProfileScreen({@required this.userId});

  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: mainBgColor,
      child: FutureBuilder(
        future: fetchUserProfile(http.Client(), widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ProfileDetails(details: snapshot.data)
              : Center(
                  child: AfricodersLoader(),
                );
        },
      ),
    );
  }
}
