import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/error_box.dart';
import 'package:africoders_mobile/components/parse_html.dart';
import 'package:africoders_mobile/model/statusModel.dart';
import 'package:africoders_mobile/screens/status/components/status_comment_textbox.dart';
import 'package:africoders_mobile/screens/status/components/update_status_textbox.dart';
import 'package:africoders_mobile/screens/status/status_home.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/comment_icons_options.dart';
import 'package:africoders_mobile/widgets/expanding_widget.dart';
import 'package:africoders_mobile/widgets/status_icons_options.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class StatusList extends StatefulWidget {
  final List<StatusModel> statuses;

  StatusList({this.statuses});

  @override
  StatusListState createState() {
    return new StatusListState();
  }
}

class StatusListState extends State<StatusList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _statusTextInput = TextEditingController();
  final TextEditingController _commentTextInput = TextEditingController();

  //Post Status Comment

  bool _isCommentError = false;
  bool _isCommentLoading = false;
  String _commentTextError, _commentErrorText;
  int selectedStatusId;
  bool isStatusSelected = false;

  _commentShowLoading() {
    setState(() {
      _isCommentLoading = true;
    });
  }

  _commentHideLoading() {
    setState(() {
      _isCommentLoading = false;
    });
  }

  _onPostComment() async {
    _commentShowLoading();

    /* setState(() => isStatusSelected = false);
    _commentTextInput.clear(); */

    if (_commentValid()) {
      var responseJson = await PostUtils.postComment(
        selectedStatusId.toString(),
        _commentTextInput.text,
      );

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
        _scaffoldKey.currentState.setState(() => isStatusSelected = false);
        _commentTextInput.clear();

        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new StatusHome();
        }));
      }
      _commentHideLoading();
    } else {
      setState(() {
        _isCommentLoading = false;
        _commentTextError;
      });
    }
  }

  _commentValid() {
    bool commentValid = true;
    if (_commentTextInput.text.isEmpty) {
      commentValid = false;
      _textError = "Comment can't be blank!";
    }
    return commentValid;
  }

//End post status comment

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

  _onPostStatus() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await PostUtils.postStatus(_statusTextInput.text);

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
        /**
				 * Removes stack and start with the new page.
				 * In this case on press back on StatusHome app will exit.
				 * **/
        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new StatusHome();
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
    if (_statusTextInput.text.isEmpty) {
      valid = false;
      _textError = "Text can't be blank!";
    }
    return valid;
  }

  Widget _statusScreen() {
    return Container(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          children: [
            ErrorBox(isError: _isError, errorText: _errorText),
            UpdateStatusTextBox(
              statusTextController: _statusTextInput,
              onPressed: _onPostStatus,
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: widget.statuses
                  .map(
                    (status) => statusMainText(
                          statusText: status.body,
                          timePosted: status.created.date,
                          userName: status.user.name,
                          imgUrl: status.user.avatarUrl,
                          disLikes: status.dislikes,
                          likes: status.likes,
                          postId: status.id,
                          shares: status.shares,
                          commentsList: status.comment,
                          userId: status.user.id,
                          commentsCount: status.replies,
                        ),
                  )
                  .toList(),
            )
          ]),
    );
  }

  Widget _loadingScreen() {
    return new Container(
        margin: const EdgeInsets.only(top: 100.0),
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      resizeToAvoidBottomPadding: false,
      backgroundColor: mainBgColor,
      key: _scaffoldKey,
      body: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          _isCommentLoading || _isLoading ? _loadingScreen() : _statusScreen(),
        ],
      ),
    );
  }

  Widget userNameText(String userName, int userId) {
    return africodersUserName(
        context: context, userName: userName, userId: userId);

    /* Text(
      userName,
      style: TextStyle(
          color: Color(0xFFFEFEFE),
          fontSize: 14.0,
          fontWeight: FontWeight.w800),
    ); */
  }

  Widget userCircleAvatar(String imgUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imgUrl),
      maxRadius: 25.0,
      minRadius: 15.0,
    );
  }

  Widget userStatusText(String statusText) {
    String statusTextParsed = parseHtmlString(statusText);
    return Text(
      //'Hey guys, this os a new status',
      statusTextParsed,
      style: TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400),
    );
  }

  Widget statusComment({
    String userName,
    String timePosted,
    String commentText,
    String imgUrl,
    int likes,
    int disLikes,
    int shares,
    int postId,
    int userId,
  }) {
    String timePostedParsed = timeago.format(DateTime.parse(timePosted));

    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: dividerColor, style: BorderStyle.solid, width: 0.70))),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(4.0, 15.0, 4.0, 1.0),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: userCircleAvatar(imgUrl),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  userNameText(userName, userId),
                  Text(
                    timePostedParsed,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFFEFEFE),
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              userStatusText(commentText),
              SizedBox(height: 1.0),
              Align(
                alignment: Alignment.bottomRight,
                child: CommentIconsOptions(
                  body: commentText,
                  dislikesCount: disLikes,
                  likesCount: likes,
                  postId: postId,
                  scaffoldKey: _scaffoldKey,
                  sharesCount: shares,
                  userId: userId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusMainText({
    String userName,
    String timePosted,
    String statusText,
    String imgUrl,
    int likes,
    int disLikes,
    int shares,
    String commentsCount,
    int postId,
    List<Comment> commentsList,
    int userId,
  }) {
    String timePostedParsed = timeago.format(DateTime.parse(timePosted));
    return Card(
      color: mainBgColor,
      elevation: 6.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ExpandWidget(
        onExpansionChanged: (value) {
          if (value == true) {
            setState(() {
              selectedStatusId = postId;
              isStatusSelected = true;
            });
          } else {
            setState(() {
              selectedStatusId = 0;
              isStatusSelected = false;
            });
          }
        },
        title: Column(
          children: <Widget>[
            //listDivider(),
            SizedBox(height: 5.0),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
              leading: userCircleAvatar(imgUrl),
              title: userNameText(userName, userId),
              trailing: Text(
                timePostedParsed,
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
            //statusIconsRow(false),
            Align(
              alignment: Alignment.bottomLeft,
              child: StatusPostIconOptions(
                body: statusText,
                dislikesCount: disLikes,
                likesCount: likes,
                postId: postId,
                scaffoldKey: _scaffoldKey,
                sharesCount: shares,
                userId: userId,
                commentsCount: commentsCount,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: commentsList
                .map(
                  (comment) => statusComment(
                        userName: comment.user.name,
                        timePosted: comment.created.date,
                        commentText: comment.body,
                        disLikes: comment.dislikes,
                        likes: comment.likes,
                        postId: comment.id,
                        shares: comment.shares,
                        imgUrl: comment.user.avatarUrl,
                        userId: comment.user.id,
                      ),
                )
                .toList(),
          ),
          //Reply text box
          Container(
            padding: EdgeInsets.all(5.0),
            child: StatusCommentTextField(
              commentController: _commentTextInput,
              onPressed: _onPostComment,
            ),
          )
        ],
      ),
    );
  }
}
