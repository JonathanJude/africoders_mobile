import 'dart:convert';

import 'package:africoders_mobile/utils/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostUtils {
  static final String host = baseUrl;
  static final String baseUrl = 'https://api.africoders.com';

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static SharedPreferences _sharedPreferences;
  static http.Client client = http.Client();

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
    ));
  }

/*
* Util to help post status
*/
  static dynamic postStatus(String text) async {
    String endPoint = '/v1/post/status';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //To Create a Blog
  static dynamic createBlog(String title, String text) async {
    String endPoint = '/v1/post/blog';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'title': title,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //To Create a Job Ad
  static dynamic createJobAd(String title, String text) async {
    String endPoint = '/v1/post/job';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'title': title,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //To Create a Link Share
  static dynamic createLinkShare(String title, String text, String url) async {
    String endPoint = '/v1/post/link';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'title': title,
        'body': text,
        'url': url
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //To Post Forum Topic
  static dynamic postForumThread(
      String title, String text, String forumId) async {
    String endPoint = '/v1/post/forum';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'title': title,
        'body': text,
        'fid': forumId
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  //To Post a Comment
  static dynamic postComment(String postId, String text) async {
    String endPoint = '/v1/comment';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'pid': postId,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Update a Post
  */
  static dynamic updatePost(String postId, String title, String text) async {
    String endPoint = '/v1/edit/post';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': postId,
        'title': title,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Update a Status
  */
  static dynamic updateStatus(String postId, String text) async {
    String endPoint = '/v1/edit/post';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': postId,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Update a Link
  */
  static dynamic updateLink(
      String postId, String title, String text, String url) async {
    String endPoint = '/v1/edit/post';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': postId,
        'body': text,
        'title': title,
        'url': url,
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Update a Comment
  */
  static dynamic updateComment(String commentId, String text) async {
    String endPoint = '/v1/edit/comment';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': commentId,
        'body': text
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Delete a Post
  */
  static dynamic deletePost(String postId) async {
    String endPoint = '/v1/del/post';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': postId
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
      client.close();

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  /*
  * to Delete a Post
  */
  static dynamic deleteComment(String commentId) async {
    String endPoint = '/v1/del/comment';
    var uri = host + endPoint;

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);

    try {
      final response = await client.post(uri, body: {
        'id': commentId
      }, headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      });
  client.close();


      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }
}
