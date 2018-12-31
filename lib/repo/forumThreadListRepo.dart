import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/model/forumThreadModel.dart';
import 'package:http/http.dart' as http;

Future<List<ForumThread>> fetchForumThreadList(
    http.Client client, String forumPath) async {
  var uri = 'https://api.africoders.com/v1/$forumPath?order=updated_at|DESC&limit=20';
  final response = await client.get(uri);
  client.close();

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final threads = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfThreads = threads.map<ForumThread>((json) {
      return ForumThread.fromJson(json);
    }).toList();
    return listOfThreads;
  } else {
    throw Exception('Failed to load internet');
  }
}

/* //Fecthing blogs with no comments
Future<List<ForumThread>> fetchForumThreadList(String forumPath) async {
  var uri = 'https://api.africoders.com/v1/$forumPath?order=updated_at|DESC';
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final threads = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfThreads = threads.map<ForumThread>((json) {
      return ForumThread.fromJson(json);
    }).toList();
    return listOfThreads;
  } else {
    throw Exception('Failed to load internet');
  }
}
 */
