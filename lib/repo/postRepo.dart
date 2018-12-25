import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/model/postModel.dart';
import 'package:http/http.dart' as http;

//Fetching blogs with comments
/* Future<List<Post>> fetchAPostWithComments(int postId) async {
  String uri = "https://api.africoders.com/v1/post?id=$postId";
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final post = mapResponse["data"].cast<Map<String, dynamic>>();
    final aPost = post.map<Post>((json) {
      return Post.fromJson(json);
    }).toList();
    return aPost;
  } else {
    throw Exception('Failed to load internet');
  }
} */

Future<Post> fetchAPostWithComments(int postId) async {
  String uri = "https://api.africoders.com/v1/post?id=$postId&include=comment";
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    Map<String, dynamic> mapPost = mapResponse['data'][0];
    return Post.fromJson(mapPost);
  } else {
    throw Exception('Failed to load internet');
  }
}
