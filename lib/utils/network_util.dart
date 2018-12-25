import 'dart:convert';
import 'package:africoders_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'auth_util.dart';

class NetworkUtils {
  static final String host = baseUrl;
  static final String baseUrl = 'https://api.africoders.com';

  //Authenticate User for Sign In
  static dynamic authenticateUser(String name, String password) async {
    var uri = host + AuthUtils.loginEndPoint;

    try {
      final response =
          await http.post(uri, body: {'name': name, 'password': password});

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //Sign Up User and get response
  static dynamic signUpUser(String name, String email, String password) async {
    var uri = host + AuthUtils.signUpEndPoint;

    try {
      final response = await http.post(uri,
          body: {'name': name, 'password': password, 'email': email});

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  static logoutUser(BuildContext context, SharedPreferences prefs) {
    prefs.setString(AuthUtils.authTokenKey, null);
    prefs.setInt(AuthUtils.userIdKey, null);
    prefs.setString(AuthUtils.nameKey, null);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new LoginPage();
    }));
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
    ));
  }

  static fetch(var authToken, var endPoint) async {
    var uri = host + endPoint;

    try {
      final response = await http.get(
        uri,
        headers: {'Authorization': authToken},
      );

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }
}
