import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/comment_text_box.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/postModel.dart';
import 'package:africoders_mobile/repo/postRepo.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/date_time_formats.dart';
import 'package:africoders_mobile/widgets/link_icons_options.dart';
import 'package:africoders_mobile/widgets/post_icons_options.dart';
import 'package:africoders_mobile/widgets/post_list.dart';
import 'package:africoders_mobile/widgets/post_options.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class LinkArticle extends StatefulWidget {
  final int postId;
  LinkArticle({this.postId});
  _LinkArticleState createState() => _LinkArticleState();
}

class _LinkArticleState extends State<LinkArticle> {
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
      } else if (responseJson['status'] != "success") {
        PostUtils.showSnackBar(_scaffoldKey, 'Authorization Error!');
      } else {
        //AuthUtils.insertDetails(_sharedPreferences, responseJson);

        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new LinkArticle(postId: widget.postId);
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

  //Launch URL
  _launchURL(String url) async {
    //const url = linkUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _linkArticleScreen() {
    return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<Post>(
            future: fetchAPostWithComments(http.Client(), widget.postId),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? linkArticle(
                      articleContent: snapshot.data.body,
                      articleTitle: snapshot.data.title,
                      timePosted: snapshot.data.created.date,
                      authorImage: snapshot.data.user.avatarUrl,
                      authorName: snapshot.data.user.name,
                      linkUrl: snapshot.data.url,
                      disLikesCount: snapshot.data.dislikes,
                      likesCount: snapshot.data.likes,
                      sharesCount: snapshot.data.shares,
                      postId: snapshot.data.id,
                      commentsCount: snapshot.data.replies,
                      articleViews: snapshot.data.views,
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
        body: _isLoading ? _loadingScreen() : _linkArticleScreen());
  }

  Widget linkArticle({
    String articleTitle,
    int postId,
    String timePosted,
    String articleContent,
    String authorImage,
    String authorName,
    String linkUrl,
    String articleViews,
    String commentsCount,
    int likesCount,
    int disLikesCount,
    int sharesCount,
    List commentsList,
    int userId,
  }) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        children: <Widget>[
          topicTitleText(articleTitle),

          SizedBox(height: 0.0),
          articleTime(timePosted, articleViews),
          SizedBox(height: 20.0),
          buildFullThreadText(articleContent, linkUrl),
          SizedBox(height: 15.0),
          LinksIconOptions(
            body: articleContent,
            title: articleTitle,
            url: linkUrl,
            scaffoldKey: _scaffoldKey,
            userId: userId,
            postId: postId,
            dislikesCount: disLikesCount,
            likesCount: likesCount,
            sharesCount: sharesCount,
          ),
          SizedBox(height: 0.0),
          authorDetails(
            authorImage: authorImage,
            authorName: authorName,
          ),
          SizedBox(height: 10.0),
          commentsText(commentsCount),
          SizedBox(height: 15.0),
          //Comments List
          PostList(
            postsList: commentsList,
            scaffoldKey: _scaffoldKey,
          ),
          SizedBox(height: 80.0)
        ],
      ),
    );
  }

  Row articleTime(String time, String views) {
    String formatTime = dateAndTimeFormatter(time);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(Icons.remove_red_eye),
        SizedBox(width: 5.0),
        Text(
          views,
          style: TextStyle(fontSize: 12.0),
        ),
        SizedBox(width: 5.0),
        Icon(Icons.timer),
        SizedBox(width: 5.0),
        Text(
          formatTime,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    );
  }

  Row commentsText(String commentsCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.comment,
          color: Color(0xFF527980),
          size: 17.0,
        ),
        SizedBox(width: 6.0),
        Text(
          'Comments ($commentsCount)',
          style: TextStyle(
              color: Color(0xFF527980),
              fontSize: 22.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Container authorDetails(
      {String authorImage, String authorName, String authorUrl}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        border: Border(
            /* top: BorderSide(
                color: dividerColor, style: BorderStyle.solid, width: 0.80), */
            bottom: BorderSide(
                color: dividerColor, style: BorderStyle.solid, width: 0.80)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Shared by',
            style: TextStyle(
                color: dividerColor,
                fontSize: 13.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 50.0,
              width: 50.0,
              child: Image.network(
                authorImage,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              authorName,
              style: TextStyle(
                  color: Color(0xFF527980),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              authorUrl ?? '',
              style: TextStyle(fontSize: 12.0, color: dividerColor),
            ),
          )
        ],
      ),
    );
  }

  Padding buildFullThreadText(String text, String linkUrl) {
    String textParse = parseHtmlString(text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            textParse,
            style: TextStyle(
              color: Color(0xFF54797F),
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            alignment: Alignment.center,
            child: clickButton(
                text: 'Open Link',
                onPressed: () {
                  _launchURL(linkUrl);
                },
                iconExists: false),
          )
        ],
      ),
    );
  }

  Widget topicTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFF527980),
            fontSize: 26.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
