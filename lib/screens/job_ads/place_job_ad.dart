import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/error_box.dart';
import 'package:africoders_mobile/screens/job_ads/components/job_content_textfield.dart';
import 'package:africoders_mobile/screens/job_ads/components/job_title_textfield.dart';
import 'package:africoders_mobile/screens/job_ads/components/place_job_ad_button.dart';
import 'package:africoders_mobile/screens/job_ads/job_article.dart';
import 'package:africoders_mobile/utils/post_utils.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:africoders_mobile/widgets/app_drawer.dart';
import 'package:africoders_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PlaceJobAd extends StatefulWidget {
  _PlaceJobAdState createState() => _PlaceJobAdState();
}

class _PlaceJobAdState extends State<PlaceJobAd> {
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

  _onPlaceJobAD() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await PostUtils.createJobAd(
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
          return new JobArticle(postId: responseJson['id']);
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
      _textError = "Job Title can't be blank!";
    }
    if (_textController.text.isEmpty) {
      valid = false;
      _textError = "Job Content can't be blank!";
    }
    return valid;
  }

  Widget _placeJobScreen() {
    return Scaffold(
      endDrawer: AppDrawer(),
      backgroundColor: mainBgColor,
      appBar: buildAppBar(context),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          children: <Widget>[
            placeAJobHeader(),
            SizedBox(height: 20.0),
            ErrorBox(isError: _isError, errorText: _errorText),
            SizedBox(height: 10.0),
            JobTitleTextField(
              titleController: _titleController,
              titleError: _titleError,
            ),
            SizedBox(height: 15.0),
            JobContentTextField(
              textController: _textController,
              textError: _textError,
            ),
            SizedBox(height: 15.0),
            PlaceJobADButton(
              onPressed: _onPlaceJobAD,
            )
          ],
        ),
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
        body: _isLoading ? _loadingScreen() : _placeJobScreen());
  }

  Widget placeAJobHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        'Place Job Ad',
        style: TextStyle(
            color: primaryTextColor,
            fontSize: 22.0,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
