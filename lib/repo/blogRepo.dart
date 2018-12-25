import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/globals.dart';
import 'package:africoders_mobile/model/blogModel.dart';
import 'package:http/http.dart' as http;

//Fecthing blogs with no comments
Future<List<Blog>> fetchBlogWithNoComments(http.Client client) async {
  final response = await client.get(blogWithNoCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final blogs = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfBlogs = blogs.map<Blog>((json) {
      return Blog.fromJson(json);
    }).toList();
    return listOfBlogs;
  } else {
    throw Exception('Failed to load internet');
  }
}
/* 
//Fecthing blogs with no comments
Future<List<Blog>> fetchBlogWithNoComments() async {
  final response = await http.get(blogWithNoCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final blogs = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfBlogs = blogs.map<Blog>((json) {
      return Blog.fromJson(json);
    }).toList();
    return listOfBlogs;
  } else {
    throw Exception('Failed to load internet');
  }
}

//Fetching blogs with comments
Future<List<Blog>> fetchBlogWithComments() async {
  final response = await http.get(blogWithCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final blogs = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfBlogs = blogs.map<Blog>((json) {
      return Blog.fromJson(json);
    }).toList();
    return listOfBlogs;
  } else {
    throw Exception('Failed to load internet');
  }
}
 */
