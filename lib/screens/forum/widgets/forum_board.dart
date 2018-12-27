import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/forumBoardModel.dart';
import 'package:africoders_mobile/screens/forum/forum_threads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumBoard extends StatelessWidget {
  final Map boardMap;
  ForumBoard({@required this.boardMap});
  @override
  Widget build(BuildContext context) {
    var boardData = new ForumBoardModel.fromMap(boardMap);
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: dividerColor, style: BorderStyle.solid, width: 1.0))),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(horizontal: 13.0),
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .push(CupertinoPageRoute<Null>(builder: (BuildContext context) {
            return new ForumThreads(
              forumPath: boardData.path,
              forumName: boardData.board,
              forumId: boardData.fid,
            );
          }));
          print(boardData.path);
        },
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            //'Chats',
            boardData.board,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 6.0),
              child: Text(
                //'Latest: how do we even make thos progress',
                'Latest: ${parseHtmlString(boardData.latest)}',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  //'2 Posts  ~  4 replies ~  24 views',
                  "${boardData.threads} Posts  ~  ${boardData.comments} Replies  ~  ${boardData.views} Views",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 10.0),
              ],
            )
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white24,
        ),
      ),
    );
  }
}
