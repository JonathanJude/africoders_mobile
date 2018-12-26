import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/model/postModel.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchAPostWithComments(http.Client client, int postId) async {
  String uri = "https://api.africoders.com/v1/post?id=$postId&include=comment";
  final response = await client.get(uri);
  client.close();

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    Map<String, dynamic> mapPost = mapResponse['data'][0];
    return Post.fromJson(mapPost);
  } else {
    throw Exception('Failed to load internet');
  }
}

/* Future<Post> fetchAPostWithComments(int postId) async {
  String uri = "https://api.africoders.com/v1/post?id=$postId&include=comment";
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    Map<String, dynamic> mapPost = mapResponse['data'][0];
    return Post.fromJson(mapPost);
  } else {
    throw Exception('Failed to load internet');
  }
} */
