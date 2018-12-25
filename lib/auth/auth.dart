import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Auth {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static SharedPreferences _sharedPreferences;

  static dynamic getUAuth() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    return authToken;
  }

  static String authToken = AuthUtils.getToken(_sharedPreferences);
  static String userName = AuthUtils.getUserName(_sharedPreferences);
  static String userId = AuthUtils.getUserId(_sharedPreferences);
  static String avatarUrl = AuthUtils.getUserAvatarUrl(_sharedPreferences);
}
