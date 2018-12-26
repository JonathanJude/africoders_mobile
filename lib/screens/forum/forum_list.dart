import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/repo/forumListRepo.dart';
import 'package:africoders_mobile/screens/forum/widgets/forum_board.dart';
import 'package:africoders_mobile/screens/forum/widgets/forum_group_card.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class ForumList extends StatefulWidget {
  _ForumListState createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: mainBgColor,
        endDrawer: AppDrawer(context: context),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchForumListing(http.Client()),
          builder: (context, snapshot) {
            //Assigning each
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ForumListings(snapshotData: snapshot.data)
                : Center(
                    child: AfricodersLoader(),
                  );
          },
        ));
  }
}

class ForumListings extends StatelessWidget {
  final Map<String, dynamic> snapshotData;
  ForumListings({this.snapshotData});

  @override
  Widget build(BuildContext context) {
//General
    Map<String, dynamic> chatsBoard = snapshotData['General']['0'];
    Map<String, dynamic> africodersBoard = snapshotData['General']['16'];
    Map<String, dynamic> ideasBoard = snapshotData['General']['17'];

//Web Design
    Map<String, dynamic> xhtmlBoard = snapshotData['Web Design']['1'];
    Map<String, dynamic> phpBoard = snapshotData['Web Design']['2'];
    Map<String, dynamic> javascriptBoard = snapshotData['Web Design']['3'];
    Map<String, dynamic> pythonBoard = snapshotData['Web Design']['4'];

//Mobile
    Map<String, dynamic> androidBoard = snapshotData['Mobile']['5'];
    Map<String, dynamic> iosBoard = snapshotData['Mobile']['6'];

//App Dev
    Map<String, dynamic> golangBoard = snapshotData['App Dev']['7'];
    Map<String, dynamic> ccppBoard = snapshotData['App Dev']['8'];
    Map<String, dynamic> javaBoard = snapshotData['App Dev']['9'];
    Map<String, dynamic> kotlinBoard = snapshotData['App Dev']['10'];
    Map<String, dynamic> dotnetBoard = snapshotData['App Dev']['11'];

//Database
    Map<String, dynamic> mysqlBoard = snapshotData['Database']['12'];
    Map<String, dynamic> mssqlBoard = snapshotData['Database']['13'];
    Map<String, dynamic> mongodbBoard = snapshotData['Database']['14'];

//Community
    Map<String, dynamic> phpbrowserboxBoard = snapshotData['Community']['15'];
    Map<String, dynamic> loungeBoard = snapshotData['Community']['18'];
    Map<String, dynamic> feedbackBoard = snapshotData['Community']['19'];

    return ListView(padding: EdgeInsets.symmetric(horizontal: 20.0), children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          'Forums',
          style: TextStyle(
              fontSize: 35.0,
              color: primaryTextColor,
              fontWeight: FontWeight.w800),
        ),
      ),
      SizedBox(height: 15.0),
      ForumGroupCard(
        forumName: 'General',
        icon: MdiIcons.globeModel,
        forumBoards: <Widget>[
          ForumBoard(boardMap: chatsBoard),
          ForumBoard(boardMap: africodersBoard),
          ForumBoard(boardMap: ideasBoard),
        ],
      ),
      ForumGroupCard(
        forumName: 'Web Design',
        icon: MdiIcons.materialDesign,
        forumBoards: <Widget>[
          ForumBoard(boardMap: xhtmlBoard),
          ForumBoard(boardMap: phpBoard),
          ForumBoard(boardMap: javascriptBoard),
          ForumBoard(boardMap: pythonBoard),
        ],
      ),
      ForumGroupCard(
        forumName: 'Mobile',
        icon: Icons.phone_android,
        forumBoards: <Widget>[
          ForumBoard(boardMap: androidBoard),
          ForumBoard(boardMap: iosBoard),
        ],
      ),
      ForumGroupCard(
        forumName: 'App Dev',
        icon: MdiIcons.desktopMac,
        forumBoards: <Widget>[
          ForumBoard(boardMap: golangBoard),
          ForumBoard(boardMap: ccppBoard),
          ForumBoard(boardMap: javaBoard),
          ForumBoard(boardMap: kotlinBoard),
          ForumBoard(boardMap: dotnetBoard),
        ],
      ),
      ForumGroupCard(
        forumName: 'Database',
        icon: MdiIcons.database,
        forumBoards: <Widget>[
          ForumBoard(boardMap: mysqlBoard),
          ForumBoard(boardMap: mssqlBoard),
          ForumBoard(boardMap: mongodbBoard),
        ],
      ),
      ForumGroupCard(
        forumName: 'Community',
        icon: MdiIcons.googleCirclesCommunities,
        forumBoards: <Widget>[
          ForumBoard(boardMap: phpbrowserboxBoard),
          ForumBoard(boardMap: loungeBoard),
          ForumBoard(boardMap: feedbackBoard),
        ],
      )
    ]);
  }
}
