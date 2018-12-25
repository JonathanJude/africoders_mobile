import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/globals.dart';
import 'package:africoders_mobile/model/jobAdModel.dart';
import 'package:http/http.dart' as http;

//Fecthing blogs with no comments
Future<List<JobAd>> fetchJobAdWithNoComments() async {
  final response = await http.get(jobAdWithNoCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final jobs = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfJobAds = jobs.map<JobAd>((json) {
      return JobAd.fromJson(json);
    }).toList();
    return listOfJobAds;
  } else {
    throw Exception('Failed to load internet');
  }
}

//Fetching blogs with comments
Future<List<JobAd>> fetchJobAdWithComments() async {
  final response = await http.get(jobAdWithCommentApi);

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final jobs = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfJobAds = jobs.map<JobAd>((json) {
      return JobAd.fromJson(json);
    }).toList();
    return listOfJobAds;
  } else {
    throw Exception('Failed to load internet');
  }
}
