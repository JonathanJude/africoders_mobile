import 'package:africoders_mobile/colors.dart';
import 'package:flutter/material.dart';

class ForumGroupCard extends StatelessWidget {
  final String forumName;
  final List<Widget> forumBoards;
  IconData icon;

  ForumGroupCard(
      {@required this.forumName, @required this.forumBoards, this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      color: mainBgColor,
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 12.0),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: primaryTextColor,
                            style: BorderStyle.solid,
                            width: 2.0))),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon ?? Icons.add,
                      color: primaryTextColor,
                    ),
                    SizedBox(width: 5.0),
                    Text(forumName,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          color: primaryTextColor,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Column(
            children: forumBoards,
            crossAxisAlignment: CrossAxisAlignment.start,
            //children: forumBoards.map((forumBoard) => forumBoard)
          ),
          SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
