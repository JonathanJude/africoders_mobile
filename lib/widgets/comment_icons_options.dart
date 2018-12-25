import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/screens/blog/blog_article.dart';
import 'package:africoders_mobile/screens/blog/blog_home.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentIconsOptions extends StatefulWidget {
  final GlobalKey scaffoldKey;
  final String body;
  final int postId;
  final int likesCount;
  final int dislikesCount;
  final int sharesCount;
  final int userId;

  CommentIconsOptions({
    @required this.scaffoldKey,
    @required this.body,
    @required this.postId,
    @required this.likesCount,
    @required this.dislikesCount,
    @required this.sharesCount,
    @required this.userId,
  });

  @override
  CommentIconsOptionsState createState() {
    return new CommentIconsOptionsState();
  }
}

class CommentIconsOptionsState extends State<CommentIconsOptions> {
  var iconSize = 17.0;
  var textSize = 12.0;
  //Handling user Authentication Token
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;

  var _authToken, _id, _name, _avatarUrl;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    String name = _sharedPreferences.getString(AuthUtils.nameKey);
    String avatarUrl = _sharedPreferences.getString(AuthUtils.avatarUrlKey);

    print(authToken);

    setState(() {
      _authToken = authToken;
      _id = id;
      _name = name;
      _avatarUrl = avatarUrl;
    });
  }

  //Delete a Post
  void displayDeleteDialog(GlobalKey scaffoldKey, int postId) {
    bool _isLoading = false;

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

    _valid() {
      bool valid = true;

      return valid;
    }

    _onDeleteComment() async {
      _showLoading();
      if (_valid()) {
        var responseJson = await PostUtils.deleteComment(postId.toString());

        print(responseJson);

        if (responseJson == null) {
          PostUtils.showSnackBar(scaffoldKey, 'Something went wrong!');
        } else if (responseJson == 'NetworkError') {
          PostUtils.showSnackBar(scaffoldKey, null);
        } else if (responseJson['status'] != "success") {
          PostUtils.showSnackBar(scaffoldKey, 'Authorization Error!');
        } else {
          scaffoldKey.currentState.setState(() {});
          Navigator.of(context).pop();
        }
        _hideLoading();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }

    AlertDialog dialogForDelete = AlertDialog(
      title: Text('Delete Comment'),
      content: Text(
        'Do you want to Delete this Comment?',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
      ),
      actions: <Widget>[
        clickButton(
          iconExists: false,
          text: 'No',
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),

        //Delete button
        RawMaterialButton(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          onPressed: _onDeleteComment,
          padding: EdgeInsets.all(2.0),
          fillColor: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Yes',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        )
      ],
    );

    AlertDialog diaglogForLoading = AlertDialog(
      content: Center(child: AfricodersLoader()),
    );

    !_isLoading
        ? showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => dialogForDelete)
        : showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => diaglogForLoading);
  }

  /// Edit Post
  /// For dialogs to edit comments and methods to send api calls

  //Edit Post Dialog

  void displayEditDialog(GlobalKey scaffoldKey, String text, int postId) {
    TextEditingController bodyController = TextEditingController(text: text);
    bool _isLoading = false;
    bool _isError = false;
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

    _valid() {
      bool valid = true;
      if (bodyController.text.isEmpty) {
        valid = false;
        _textError = "Title can't be blank!";
      }
      return valid;
    }

    _onEditComment() async {
      _showLoading();
      if (_valid()) {
        var responseJson = await PostUtils.updateComment(
            postId.toString(), bodyController.text);

        print(responseJson);

        if (responseJson == null) {
          PostUtils.showSnackBar(scaffoldKey, 'Something went wrong!');
        } else if (responseJson == 'NetworkError') {
          PostUtils.showSnackBar(scaffoldKey, null);
        } else if (responseJson['status'] != "success") {
          PostUtils.showSnackBar(scaffoldKey, 'Authorization Error!');
        } else {
          scaffoldKey.currentState.setState(() {});
          Navigator.of(context).pop();
        }
        _hideLoading();
      } else {
        setState(() {
          _isLoading = false;
          _textError;
        });
      }
    }

    AlertDialog dialogForEdit = AlertDialog(
      title: Text(
        'Edit Post',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            maxLines: 5,
            controller: bodyController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Comment',
              labelStyle:
                  TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: buttonColor,
                  style: BorderStyle.solid,
                  width: 0.80,
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        clickButton(
          iconExists: false,
          text: 'Cancel',
          onPressed: () {
            if (Navigator.of(scaffoldKey.currentContext).canPop()) {
              Navigator.of(scaffoldKey.currentContext).pop();
            }
          },
        ),
        clickButton(
          iconExists: false,
          text: 'Edit',
          onPressed: _onEditComment,
        )
      ],
    );

    AlertDialog diaglogForLoading = AlertDialog(
      content: Center(child: AfricodersLoader()),
    );

//display dialog
    /* _isLoading
        ? showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => diaglogForLoading)
        : showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => dialogForEdit); */

    !_isLoading
        ? showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => dialogForEdit)
        : showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (BuildContext context) => diaglogForLoading);
  }

  //ToEdit Post
  Widget editPostButton(GlobalKey scaffoldKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.edit,
            size: iconSize,
          ),
          onPressed: () {
            displayEditDialog(scaffoldKey, widget.body, widget.postId);
          },
          color: buttonColor,
          iconSize: iconSize,
        ),
      ],
    );
  }

  //Delete post  button
  Widget deletePostButton(GlobalKey scaffoldKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.clear,
            size: iconSize,
            color: Colors.red,
          ),
          onPressed: () {
            displayDeleteDialog(scaffoldKey, widget.postId);
          },
          color: Color(0xFF45ADA6),
          iconSize: iconSize,
        ),
      ],
    );
  }

//Build  function
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          likeButton(),
          disLikeButton(),
          shareButton(),
          _id == widget.userId
              ? editPostButton(widget.scaffoldKey)
              : SizedBox(),
          _id == widget.userId
              ? deletePostButton(widget.scaffoldKey)
              : SizedBox(),
        ],
      ),
    );
  }

  Widget likeButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.thumb_up,
            size: iconSize,
          ),
          onPressed: () {
            //TODO: add likePost onPressed
          },
          color: Color(0xFF45ADA6),
          iconSize: iconSize,
        ),
        Text(
          widget.likesCount.toString(),
          style: TextStyle(fontSize: textSize, color: Color(0xFF45ADA6)),
        )
      ],
    );
  }

  //Dislike Button
  Widget disLikeButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.thumb_down,
            size: iconSize,
          ),
          onPressed: () {
            //TODO: add dislikePost onPressed
          },
          color: Color(0xFF45ADA6),
          iconSize: iconSize,
        ),
        Text(
          widget.dislikesCount.toString(),
          style: TextStyle(fontSize: textSize, color: Color(0xFF45ADA6)),
        )
      ],
    );
  }

  //Share Button
  Widget shareButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            size: iconSize,
          ),
          onPressed: () {
            //TODO: add sharePost onPressed
          },
          color: Color(0xFF45ADA6),
          iconSize: iconSize,
        ),
        Text(
          widget.sharesCount.toString(),
          style: TextStyle(fontSize: textSize, color: Color(0xFF45ADA6)),
        )
      ],
    );
  }
}
