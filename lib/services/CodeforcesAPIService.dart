import 'dart:convert';

import 'package:codeforces_assistant/models/Contest.dart';
import 'package:codeforces_assistant/models/RatingChange.dart';
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

  static Future<List<RatingChange>> getContestHistory(
      {@required String userId}) async {
    Response response =
        await get(Uri.parse('${baseURL}user.rating?handle=$userId'));
    return RatingChange.listFromJson(jsonDecode(response.body));
  }

  static Future<List<List<Contest>>> getAllContests() async {
    Response response = await get(Uri.parse('${baseURL}contest.list'));

    return Contest.listsFromJson(jsonDecode(response.body));
  }

  static String getContestURL(int cid) {
    return 'https://codeforces.com/contest/$cid';
  }
}
