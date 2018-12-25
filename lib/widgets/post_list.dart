import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/widgets/comment_icons_options.dart';
import 'package:africoders_mobile/widgets/date_time_formats.dart';
import 'package:africoders_mobile/widgets/post_options.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostList extends StatelessWidget {
  final List postsList;
  final GlobalKey scaffoldKey;
  PostList({@required this.postsList, @required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: postsList
          .map(
            (post) => statusComment(
                  userName: post.user.name,
                  timePosted: post.created.date,
                  commentText: post.body,
                  imgUrl: post.user.avatarUrl,
                  disLikesCount: post.dislikes,
                  likesCount: post.likes,
                  postId: post.id,
                  sharesCount: post.shares,
                  userId: post.user.id,
                ),
          )
          .toList(),
    );
  }

  Widget userNameText(String userName) {
    return Text(
      userName,
      style: TextStyle(
          //color: Color(0xFFFEFEFE),
          color: Color(0xFF54797F),
          fontSize: 14.0,
          fontWeight: FontWeight.w800),
    );
  }

  Widget userCircleAvatar(String imgUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imgUrl),
      maxRadius: 25.0,
      minRadius: 15.0,
    );
  }

  Widget userStatusText(String statusText) {
    return Text(
      //'Hey guys, this os a new status',
      statusText,
      style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Color(0xFF54797F)),
    );
  }

  Widget statusComment({
    String userName,
    String timePosted,
    String commentText,
    String imgUrl,
    int likesCount,
    int disLikesCount,
    int sharesCount,
    int postId,
    int userId,
  }) {
    String timePostedFormat = dateAndTimeFormatter(timePosted);
    commentText = parseHtmlString(commentText);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: dividerColor, style: BorderStyle.solid, width: 0.70),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: userCircleAvatar(imgUrl),
                ),
                userNameText(userName),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      timePostedFormat,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF45ADA6),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            userStatusText(commentText),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: CommentIconsOptions(
                body: commentText,
                dislikesCount: disLikesCount,
                likesCount: likesCount,
                postId: postId,
                scaffoldKey: scaffoldKey,
                sharesCount: sharesCount,
                userId: userId,
              ),
            )
          ],
        ),
      ),
    );
  }
}
