import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/widgets/comment_icons_options.dart';
import 'package:africoders_mobile/widgets/date_time_formats.dart';
import 'package:africoders_mobile/widgets/render_html.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  final List postsList;
  final GlobalKey scaffoldKey;
  PostList({@required this.postsList, @required this.scaffoldKey});

  @override
  PostListState createState() {
    return new PostListState();
  }
}

class PostListState extends State<PostList> {
  //Handling user Authentication Token
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;

  var _id;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    var id = _sharedPreferences.getInt(AuthUtils.userIdKey);

    setState(() {
      _id = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.postsList
          .map(
            (post) => postComment(
                  userName: post.user.name,
                  timePosted: post.created.date,
                  commentText: post.body,
                  imgUrl: post.user.avatarUrl,
                  disLikesCount: post.dislikes,
                  likesCount: post.likes,
                  postId: post.id,
                  sharesCount: post.shares,
                  userId: post.user.id,
                  currentUserId: _id,
                ),
          )
          .toList(),
    );
  }

  Widget userNameText(String userName, int userId, BuildContext context) {
    return africodersUserName(
      context: context,
      userName: userName,
      userId: userId,
      isColored: true,
    );
  }

  Widget userCircleAvatar(String imgUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imgUrl),
      maxRadius: 25.0,
      minRadius: 15.0,
    );
  }

  Widget userPostText(String statusText) {
    return RenderHtml(
      htmlText: statusText,
      textStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF54797F),
      ),
    );
    /* return Text(
      statusText,
      style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Color(0xFF54797F)),
    ); */
  }

  Widget postComment({
    String userName,
    String timePosted,
    String commentText,
    String imgUrl,
    int likesCount,
    int disLikesCount,
    int sharesCount,
    int postId,
    int userId,
    int currentUserId,
  }) {
    String timePostedFormat = dateAndTimeFormatter(timePosted);
    //commentText = parseHtmlString(commentText);

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
                userNameText(
                    userName, userId, widget.scaffoldKey.currentContext),
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
            userPostText(commentText),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: CommentIconsOptions(
                body: commentText,
                dislikesCount: disLikesCount,
                likesCount: likesCount,
                postId: postId,
                scaffoldKey: widget.scaffoldKey,
                sharesCount: sharesCount,
                userId: userId,
                currentUserId: currentUserId,
              ),
            )
          ],
        ),
      ),
    );
  }
}
