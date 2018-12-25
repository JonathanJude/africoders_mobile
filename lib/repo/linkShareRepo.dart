import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/globals.dart';
import 'package:africoders_mobile/model/linkShareModel.dart';
import 'package:http/http.dart' as http;

//Fecthing blogs with no comments
Future<List<LinkShare>> fetchLinkShareWithNoComments() async {
  final response = await http.get(linkShareWithNoCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final links = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfLinkShares = links.map<LinkShare>((json) {
      return LinkShare.fromJson(json);
    }).toList();
    return listOfLinkShares;
  } else {
    throw Exception('Failed to load internet');
  }
}

//Fetching blogs with comments
Future<List<LinkShare>> fetchLinkShareWithComments() async {
  final response = await http.get(linkShareWithCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final links = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfLinkShares = links.map<LinkShare>((json) {
      return LinkShare.fromJson(json);
    }).toList();
    return listOfLinkShares;
  } else {
    throw Exception('Failed to load internet');
  }
}
