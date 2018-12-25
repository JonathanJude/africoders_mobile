import 'package:africoders_mobile/colors.dart';
import 'package:africoders_mobile/components/error_box.dart';
import 'package:africoders_mobile/components/login_button.dart';
import 'package:africoders_mobile/components/login_name_textfield.dart';
import 'package:africoders_mobile/components/login_password_textfield.dart';
import 'package:africoders_mobile/screens/signup.dart';
import 'package:africoders_mobile/screens/status/status_home.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:africoders_mobile/utils/network_util.dart';
import 'package:africoders_mobile/widgets/africdoders_loader.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_offline/flutter_offline.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  Color _eyeButtonColor = Color(0xFF9CE0AD);
  bool _isLoading = false;
  TextEditingController _nameController, _passwordController;
  String _errorText, _nameError, _passwordError;

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

  _authenticateUser() async {
    _showLoading();
    if (_valid()) {
      var responseJson = await NetworkUtils.authenticateUser(
          _nameController.text, _passwordController.text);

      print(responseJson);

      if (responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');
      } else if (responseJson == 'NetworkError') {
        NetworkUtils.showSnackBar(_scaffoldKey, null);
      } else if (responseJson['status'] != "success") {
        NetworkUtils.showSnackBar(_scaffoldKey, 'Invalid Email/Password');
      } else {
        AuthUtils.insertDetails(_sharedPreferences, responseJson);
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
        _nameError;
        _passwordError;
      });
    }
  }

  _valid() {
    bool valid = true;

    if (_nameController.text.isEmpty) {
      valid = false;
      _nameError = "User name can't be blank!";
    }
    if (_passwordController.text.isEmpty) {
      valid = false;
      _passwordError = "Password can't be blank!";
    } else if (_passwordController.text.length < 6) {
      valid = false;
      _passwordError = "Password is invalid!";
    }

    return valid;
  }

  Widget _loginScreen() {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 150.0),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/logo_white.png'),
          ),
          SizedBox(height: 30.0),
          new ErrorBox(isError: _isError, errorText: _errorText),
          new LoginNameTextField(
            nameController: _nameController,
            nameError: _nameError,
          ),
          SizedBox(
            height: 30.0,
          ),
          new LoginPasswordTextField(
            passwordController: _passwordController,
            isObscured: _obscureText,
            passwordError: _passwordError,
            togglePassword: _togglePassword,
            eyeButtonColor: _eyeButtonColor,
          ),
          SizedBox(
            height: 15.0,
          ),
          new LoginButton(onPressed: _authenticateUser),
          SizedBox(height: 30.0),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text('Not on Africoders?',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new SignUpPage();
                    }));
                  },
                  child: Text(
                    'Create an Account',
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

  Widget buildOfflineScreen() {
    return Container(
      alignment: Alignment.center,
      child: Text('youre offline'),
    );
  }

  Widget buildOnlineScreen() {
    //return _isLoading ? _loadingScreen() : _loginScreen();
    return Text('back on line');
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new AfricodersLoader(),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'Please Wait',
                style: new TextStyle(color: buttonColor, fontSize: 16.0),
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
        body: _isLoading ? _loadingScreen() : _loginScreen()
        /* body: OfflineBuilder(
            connectivityBuilder: (context, connectivity, child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return connected
                  ? _isLoading ? _loadingScreen() : _loginScreen()
                  : buildOfflineScreen();
            },
            child: _isLoading ? _loadingScreen() : _loginScreen()) */
        );

    /* return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected ? buildLoginScreen() : buildOfflineScreen();
      },
      //child: buildLoginScreen(),
    ); */
  }
}
