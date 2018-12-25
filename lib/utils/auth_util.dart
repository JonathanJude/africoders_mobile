import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static final String loginEndPoint = '/v1/user/login';
  static final String signUpEndPoint = '/v1/user/signup';

  // Keys to store and fetch data from SharedPreferences
  static final String authTokenKey = 'token';
  static final String userIdKey = 'id';
  static final String nameKey = 'name';
  static final String emailKey = 'email';
  static final String vanityKey = 'vanity';
  static final String genderKey = 'gender';
  static final String avatarUrlKey = 'avatarUrl';
  static final String profileUrlKey = 'profileUrl';
  static final String firstNameKey = 'first';
  static final String lastNameKey = 'last';
  static final String bioKey = 'bio';
  static final String urlKey = 'url';
  static final String companyKey = 'company';
  static final String locationKey = 'location';
  static final String occupationKey = 'occupation';
  static final String phoneKey = 'phone';
  static final String birthDateKey = 'birthdate';

  //Get User Token
  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  //Get User name
  static String getUserName(SharedPreferences prefs) {
    return prefs.getString(nameKey);
  }

  //Get User ID
  static String getUserId(SharedPreferences prefs) {
    return prefs.getString(userIdKey);
  }

  //Get User Avatar url
  static String getUserAvatarUrl(SharedPreferences prefs) {
    return prefs.getString(avatarUrlKey);
  }

  static insertDetails(SharedPreferences prefs, var response) {
    prefs.setString(authTokenKey, response['token']);
    var user = response['data'][0];
    prefs.setInt(userIdKey, user['id']);
    prefs.setString(nameKey, user['name']);
    prefs.setString(emailKey, user['email']);
    prefs.setString(vanityKey, user['vanity']);
    prefs.setString(genderKey, user['gender']);
    prefs.setString(avatarUrlKey, user['avatarUrl']);
    prefs.setString(profileUrlKey, user['profileUrl']);
    prefs.setString(firstNameKey, user['first']);
    prefs.setString(lastNameKey, user['last']);
    prefs.setString(bioKey, user['bio']);
    prefs.setString(urlKey, user['url']);
    prefs.setString(companyKey, user['company']);
    prefs.setString(locationKey, user['location']);
    prefs.setString(occupationKey, user['occupation']);
    prefs.setString(phoneKey, user['phone']);
    prefs.setString(birthDateKey, user['birthdate']);
  }
}
