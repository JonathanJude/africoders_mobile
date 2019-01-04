import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/error_box.dart';
import 'package:africoders_mobile/screens/blog/blog_home.dart';
import 'package:africoders_mobile/screens/blog/components/blog_content_textfield.dart';
import 'package:africoders_mobile/screens/blog/components/blog_title_textfield.dart';
import 'package:africoders_mobile/screens/blog/components/create_blog_button.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  String _titleError;
  String _textError;
  String _errorText;
  bool _isError = false;
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

  _onCreateBlog() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await PostUtils.createBlog(
          _titleController.text, _textController.text);

      print(responseJson);

      if (responseJson == null) {
        PostUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        PostUtils.showSnackBar(_scaffoldKey, null);
      } else if (responseJson['status'] != "success") {
        PostUtils.showSnackBar(_scaffoldKey, 'Authorization Error!');
      } else {
        //AuthUtils.insertDetails(_sharedPreferences, responseJson);
        /**
				 * Removes stack and start with the new page.
				 * In this case on press back on BlogHome app will exit.
				 * **/
        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new BlogHome();
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
    if (_titleController.text.isEmpty) {
      valid = false;
      _textError = "Blog Title can't be blank!";
    }
    if (_textController.text.isEmpty) {
      valid = false;
      _textError = "Blog Content can't be blank!";
    }
    return valid;
  }

  Widget _createBlogScreen() {
    return Scaffold(
      endDrawer: AppDrawer(),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          startBlogHeader(),
          SizedBox(height: 20.0),
          ErrorBox(isError: _isError, errorText: _errorText),
          SizedBox(height: 10.0),
          BlogTitleTextField(
            titleController: _titleController,
            titleError: _titleError,
          ),
          SizedBox(height: 15.0),
          BlogContentTextField(
            textController: _textController,
            textError: _textError,
          ),
          SizedBox(height: 15.0),
          CreateBlogButton(
            onPressed: _onCreateBlog,
          )
        ],
      ),
    );
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
        resizeToAvoidBottomPadding: false,
        backgroundColor: mainBgColor,
        key: _scaffoldKey,
        body: _isLoading ? _loadingScreen() : _createBlogScreen());
  }

  Widget startBlogHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'Start New Blog',
        style: TextStyle(
            color: primaryTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
