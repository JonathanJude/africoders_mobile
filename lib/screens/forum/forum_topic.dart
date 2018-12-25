import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/comment_text_box.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/postModel.dart';
import 'package:africoders_mobile/repo/postRepo.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/date_time_formats.dart';
import 'package:africoders_mobile/widgets/post_icons_options.dart';
import 'package:africoders_mobile/widgets/post_list.dart';
import 'package:africoders_mobile/widgets/post_options.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumTopicScreen extends StatefulWidget {
  final int postId;
  ForumTopicScreen({this.postId});
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends State<ForumTopicScreen> {
  /*
   * 
   * Here, we handle posting of comments
   * 
   */
  TextEditingController _commentTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isError = false;
  bool _isLoading = false;
  String _textError, _errorText;

  _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  _onPostComment() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await PostUtils.postComment(
          widget.postId.toString(), _commentTextController.text);

      print(responseJson);

      if (responseJson == null) {
        PostUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        PostUtils.showSnackBar(_scaffoldKey, null);
      } else if (responseJson['status'] == 'error') {
        PostUtils.showSnackBar(_scaffoldKey, responseJson['error']['body'][0]);
      } else if (responseJson['status'] != "success") {
        PostUtils.showSnackBar(_scaffoldKey, 'Authorization Error!');
      } else {
        //AuthUtils.insertDetails(_sharedPreferences, responseJson);

        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new ForumTopicScreen(postId: widget.postId);
        }));
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _textError;
      });
    }
  }

  _valid() {
    bool valid = true;
    if (_commentTextController.text.isEmpty) {
      valid = false;
      _textError = "Comment can't be blank!";
    }
    return valid;
  }

  Widget _forumThreadScreen() {
    return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<Post>(
            future: fetchAPostWithComments(widget.postId),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? forumThreadContainer(
                      threadContent: snapshot.data.body,
                      threadTitle: snapshot.data.title,
                      timePosted: snapshot.data.created.date,
                      originalPosterImage: snapshot.data.user.avatarUrl,
                      originalPosterName: snapshot.data.user.name,
                      disLikesCount: snapshot.data.dislikes,
                      likesCount: snapshot.data.likes,
                      sharesCount: snapshot.data.shares,
                      postId: snapshot.data.id,
                      commentsCount: snapshot.data.replies,
                      threadViews: snapshot.data.views,
                      commentsList: snapshot.data.comment,
                      userId: snapshot.data.user.id,
                    )
                  : Center(
                      child: AfricodersLoader(),
                    );
            },
          ),
          CommentTextBox(
            commentTextController: _commentTextController,
            onPressed: _onPostComment,
          )
        ]);
  }

  Widget _loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
            child: new Column(
          children: <Widget>[
            new AfricodersLoader(),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'Please Wait',
                style: new TextStyle(color: Color(0xFF9CE0AD), fontSize: 16.0),
              ),
            )
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: AppDrawer(context: context),
        appBar: buildAppBar(context),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: _isLoading ? _loadingScreen() : _forumThreadScreen());
  }

  ListView forumThreadContainer({
    String threadTitle,
    int postId,
    String timePosted,
    String threadContent,
    String originalPosterImage,
    String originalPosterName,
    String threadViews,
    String commentsCount,
    int likesCount,
    int disLikesCount,
    int sharesCount,
    List commentsList,
    int userId,
  }) {
    threadTitle = parseHtmlString(threadTitle);
    threadContent = parseHtmlString(threadContent);
    timePosted = dateAndTimeFormatter(timePosted);
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        topicTitleText(threadTitle),
        SizedBox(height: 15.0),
        userDetails(originalPosterImage, originalPosterName, timePosted),
        SizedBox(height: 20.0),
        buildFullThreadText(threadContent),
        SizedBox(height: 15.0),
        PostIconsOptions(
          body: threadContent,
          postId: postId,
          scaffoldKey: _scaffoldKey,
          title: threadTitle,
          userId: userId,
          dislikesCount: disLikesCount,
          likesCount: likesCount,
          sharesCount: sharesCount,
        ),
        SizedBox(height: 10.0),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
/*         SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.comment,
              color: Color(0xFF527980),
              size: 17.0,
            ),
            SizedBox(width: 6.0),
            Text(
              'Comments',
              style: TextStyle(
                  color: Color(0xFF527980),
                  fontSize: 22.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ), */
        SizedBox(height: 15.0),
        PostList(
          postsList: commentsList,
          scaffoldKey: _scaffoldKey,
        ),
        SizedBox(height: 80.0),
      ],
    );
  }

  Widget topicTitleText(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFF527980),
            fontSize: 28.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget userDetails(
      String imgUrl, String originalPosterName, String timePosted) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
          minRadius: 20.0,
          maxRadius: 20.0,
        ),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Started by $originalPosterName',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF44ADA6)),
            ),
            Text(
              'on $timePosted',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64828A),
              ),
            )
          ],
        )
      ],
    );
  }

  Padding buildFullThreadText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF54797F),
          fontSize: 16.0,
        ),
      ),
    );
  }
}