import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/screens/blog/blog_home.dart';
import 'package:africoders_mobile/screens/forum/forum_list.dart';
import 'package:africoders_mobile/screens/job_ads/jobs_home.dart';
import 'package:africoders_mobile/screens/link/links_home.dart';
import 'package:africoders_mobile/screens/status/status_home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeDrawer extends StatefulWidget {
  @override
  HomeDrawerState createState() {
    return new HomeDrawerState();
  }
}

class HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: drawerContentBgColor,
      color: mainBgColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          itemButton(context, 'Home', StatusHome(), MdiIcons.home),
          itemButton(context, 'Blog', BlogHome(), MdiIcons.blogger),
          itemButton(context, 'Forums', ForumList(), MdiIcons.forum),
          itemButton(context, 'Jobs', JobHome(), MdiIcons.worker),
          itemButton(context, 'Links', LinkHome(), MdiIcons.link),
        ],
      ),
    );
  }

  Widget itemButton(BuildContext context, String name, Widget navigatorScreen,
      IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Color(0xFF7EC6C2), style: BorderStyle.solid, width: 0.80),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          size: 25.0,
          color: buttonColor,
        ),
        title: Text(
          name,
          style: TextStyle(
              color: buttonColor, fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: buttonColor,
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => navigatorScreen));
        },
      ),
    );
  }
}
