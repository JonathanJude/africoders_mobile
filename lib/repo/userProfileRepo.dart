import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/model/userProfileModel.dart';
import 'package:http/http.dart' as http;

Future<UserProfile> fetchUserProfile(http.Client client, int userId) async {
  String uri = "https://api.africoders.com/v1/profile/$userId";
  final response = await client.get(uri);
  client.close();

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    Map<String, dynamic> mapPost = mapResponse['profile'];
    return UserProfile.fromJson(mapPost);
  } else {
    throw Exception('Failed to load internet');
  }
}
