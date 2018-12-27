import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostIconsOptions extends StatefulWidget {
  final GlobalKey scaffoldKey;
  final String title;
  final String body;
  final int postId;
  final int likesCount;
  final int dislikesCount;
  final int sharesCount;
  final int userId;

  PostIconsOptions({
    @required this.scaffoldKey,
    @required this.title,
    @required this.body,
    @required this.postId,
    @required this.likesCount,
    @required this.dislikesCount,
    @required this.sharesCount,
    @required this.userId,
  });

  @override
  PostIconsOptionsState createState() {
    return new PostIconsOptionsState();
  }
}

class PostIconsOptionsState extends State<PostIconsOptions> {
  var iconSize = 17.0;
  var textSize = 12.0;
  var iconButtonPadding = EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0);

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

//TODO: CONTINUE FROM HERE
    _onDeletePost() async {
      _showLoading();
      if (_valid()) {
        var responseJson = await PostUtils.deletePost(postId.toString());

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
          //_textError;
        });
      }
    }

    AlertDialog dialogForDelete = AlertDialog(
      title: Text('Delete'),
      content: Text(
        'Do you want to Delete this Post?',
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
          onPressed: _onDeletePost,
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

    showDialog(
        barrierDismissible: false,
        context: scaffoldKey.currentContext,
        builder: (BuildContext context) =>
            _isLoading ? diaglogForLoading : dialogForDelete);
  }

  /// Edit Post
  /// For dialogs to edit posts and methods to send api calls

  //Edit Post Dialog
  void displayEditDialog(
      GlobalKey scaffoldKey, String title, String text, int postId) {
    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController bodyController = TextEditingController(text: text);

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

    _valid() {
      bool valid = true;
      if (titleController.text.isEmpty) {
        valid = false;
        _textError = "Title can't be blank!";
      }
      return valid;
    }

    _onEditPost() async {
      _showLoading();
      if (_valid()) {
        var responseJson = await PostUtils.updatePost(
            postId.toString(), titleController.text, bodyController.text);

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
            controller: titleController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Title',
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
          ),
          SizedBox(height: 8.0),
          TextField(
            maxLines: 5,
            controller: bodyController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Body',
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
          onPressed: _onEditPost,
        )
      ],
    );

    AlertDialog diaglogForLoading = AlertDialog(
      content: Center(child: AfricodersLoader()),
    );

    showDialog(
        context: scaffoldKey.currentContext,
        builder: (BuildContext context) =>
            _isLoading ? diaglogForLoading : dialogForEdit);
  }

  //ToEdit Post
  Widget editPostButton(GlobalKey scaffoldKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          padding: iconButtonPadding,
          icon: Icon(
            Icons.edit,
            size: iconSize,
          ),
          onPressed: () {
            displayEditDialog(
                scaffoldKey, widget.title, widget.body, widget.postId);
          },
          color: Color(0xFF45ADA6),
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
          padding: iconButtonPadding,
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
          padding: iconButtonPadding,
          icon: Icon(Icons.thumb_up),
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
          padding: iconButtonPadding,
          icon: Icon(Icons.thumb_down),
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
          padding: iconButtonPadding,
          icon: Icon(Icons.share),
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
