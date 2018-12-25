import 'package:flutter_test/flutter_test.dart';
import 'package:africoders_mobile/auth/auth.dart';
import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test("authorization", () async {
    //expect(Auth.getUAuth, "JudeJay");
    SharedPreferences _sharedPreferences;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _sharedPreferences = await _prefs;
    expect(AuthUtils.getToken(_sharedPreferences), "JudeJay");
  });
}
