import 'dart:convert';

import 'package:codeforces_assistant/models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CodeforcesAPIService {
  static String baseURL = 'https://codeforces.com/api/';

  static Future<User> getUser({@required String userId}) async {
    Response response =
        await get(Uri.parse('${baseURL}user.info?handles=$userId'));
    return User.fromJson(jsonDecode(response.body));
  }

  static Future<Response> getContestHistory({@required String userId}) {
    return get(Uri.parse('${baseURL}user.rating?handle=$userId'));
  }

  static Future<Response> getAllContests() {
    return get(Uri.parse('${baseURL}contest.list'));
  }
}
