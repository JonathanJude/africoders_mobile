import 'dart:async';
import 'dart:convert';
import 'package:africoders_mobile/globals.dart';
import 'package:http/http.dart' as http;

import 'package:africoders_mobile/model/statusModel.dart';

Future<List<StatusModel>> fetchStatusComments(http.Client client) async {
  final response = await client.get(statusApi);
  client.close();

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final statuses = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfStatus = statuses.map<StatusModel>((json) {
      return StatusModel.fromJson(json);
    }).toList();
    return listOfStatus;
  } else {
    throw Exception('Failed to load status');
  }
}

