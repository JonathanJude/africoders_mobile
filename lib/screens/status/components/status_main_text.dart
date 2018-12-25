/* import 'package:flutter/material.dart';

class StatusMinText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpandWidget(
        title: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
              leading: userCircleAvatar(imgUrl),
              title: userNameText(userName),
              trailing: Text(
                timePosted,
                //timePosted,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFFEFEFE),
                    fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.centerLeft,
              child: userStatusText(statusText),
            ),
            statusIconsRow(false),
            SizedBox(height: 8.0),
            listDivider(),
          ],
        ),
        children: commentsList
            .map(
              (comment) => statusComment(
                  userName: comment.user.name,
                  timePosted: comment.created.date,
                  commentText: comment.body,
                  imgUrl: comment.user.avatarUrl),
            )
            .toList());
  }
    );
  }
} */
