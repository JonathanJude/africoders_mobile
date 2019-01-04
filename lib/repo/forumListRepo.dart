import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/globals.dart';
import 'package:http/http.dart' as http;

//Fecthing blogs with no comments
Future<Map<String, dynamic>> fetchForumListing(http.Client client) async {
  final response = await client.get(forumListingApi);
  client.close();

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    return mapResponse;
  } else {
    throw Exception('Failed to load internet');
  }
}
