import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/error_box.dart';
import 'package:africoders_mobile/components/signup_button.dart';
import 'package:africoders_mobile/components/signup_email_textfield.dart';
import 'package:africoders_mobile/components/signup_name_textfield.dart';
import 'package:africoders_mobile/components/signup_password_textfield.dart';
import 'package:africoders_mobile/screens/signup_successful.dart';
import 'package:africoders_mobile/screens/status/status_home.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/components/email_validator.dart';
import 'package:africoders_mobile/utils/network_util.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  Color _eyeButtonColor = Color(0xFF9CE0AD);
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorText, _nameError, _emailError, _passwordError;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
    _nameController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    if (authToken != null) {
      Navigator.of(_scaffoldKey.currentContext).pushReplacement(
          MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new StatusHome();
      }));
    }
  }

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

  _signUpUser() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await NetworkUtils.signUpUser(_nameController.text,
          _emailController.text, _passwordController.text);

      print(responseJson);

      if (responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        NetworkUtils.showSnackBar(_scaffoldKey, null);
      } else if (responseJson['status'] != "success") {
        if (responseJson['error']['email'] != null) {
          NetworkUtils.showSnackBar(
              _scaffoldKey, 'Email Adrress already taken');
        } else if (responseJson['error']['name'] != null) {
          NetworkUtils.showSnackBar(_scaffoldKey, 'Username already taken');
        }
      } else {
        AuthUtils.insertDetails(_sharedPreferences, responseJson);
        var name = responseJson['data'][0]['name'];
        /**
				 * Removes stack and start with the new page.
				 * In this case on press back on StatusHome app will exit.
				 * **/
        NetworkUtils.showSnackBar(_scaffoldKey, 'Registration Successful!');
        Navigator.of(_scaffoldKey.currentContext).pushReplacement(
            MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new SignUpSuccess(userName: name);
        }));
      }
      _hideLoading();
    } else {
      setState(() {
        _isLoading = false;
        _nameError;
        _emailError;
        _passwordError;
      });
    }
  }

  _valid() {
    bool valid = true;

    if (_nameController.text.isEmpty) {
      valid = false;
      _nameError = "User name can't be blank!";
    } else if (_emailController.text.isEmpty) {
      valid = false;
      _emailError = "Email can't be blank!";
    } else if (!_emailController.text.contains(EmailValidator.regex)) {
      valid = false;
      _emailError = "Enter valid email!";
    } else if (_passwordController.text.isEmpty) {
      valid = false;
      _passwordError = "Password can't be blank!";
    } else if (_passwordController.text.length < 6) {
      valid = false;
      _passwordError = "Password is invalid!";
    }
    return valid;
  }

  Widget _signUpScreen() {
    return Container(
      child: ListView(
        children: <Widget>[
          //SizedBox(height: size.height / 5),
          SizedBox(height: 150.0),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo_white.png'),
          ),
          SizedBox(height: 30.0),
          new ErrorBox(isError: _isError, errorText: _errorText),
          new SignUpNameTextField(
              nameController: _nameController, nameError: _nameError),
          SizedBox(height: 20.0),
          new SignUpEmailTextField(
              emailController: _emailController, emailError: _emailError),
          SizedBox(height: 20.0),
          new SignUpPasswordTextField(
            passwordController: _passwordController,
            isObscured: _obscureText,
            passwordError: _passwordError,
            togglePassword: _togglePassword,
            eyeButtonColor: _eyeButtonColor,
          ),
          SizedBox(height: 15.0),

          new SignUpButton(onPressed: _signUpUser),
          SizedBox(height: 30.0),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text('Already on Africoders?',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Login Here',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _togglePassword() {
    //setState(() {
    //_obscureText = !_obscureText;
    if (_obscureText) {
      setState(() {
        _obscureText = false;
        _eyeButtonColor = Colors.grey;
      });
    } else {
      setState(() {
        _obscureText = true;
        _eyeButtonColor = Color(0xFF9CE0AD);
      });
    }
    //});
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
        backgroundColor: mainBgColor,
        key: _scaffoldKey,
        body: _isLoading ? _loadingScreen() : _signUpScreen());
  }
}
