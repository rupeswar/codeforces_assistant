import 'package:flutter/material.dart';

class Contest {
  Contest({
    @required this.id,
    @required this.name,
    @required this.type,
    @required this.phase,
    @required this.frozen,
    @required this.durationSeconds,
    @required this.startTimeSeconds,
    @required this.relativeTimeSeconds,
  });

  final int id;
  final String name;
  final String type;
  final String phase;
  final bool frozen;
  final int durationSeconds;
  final int startTimeSeconds;
  final int relativeTimeSeconds;

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        phase: json["phase"],
        frozen: json["frozen"],
        durationSeconds: json["durationSeconds"],
        startTimeSeconds: json["startTimeSeconds"],
        relativeTimeSeconds: json["relativeTimeSeconds"],
      );

  static List<List<Contest>> listsFromJson(Map<String, dynamic> json) {
    List contestJsonArray = json['result'];

    if (contestJsonArray == null) return null;

    var upcomingContestArray = List<Contest>.filled(0, null, growable: true);
    var pastContestArray = List<Contest>.filled(0, null, growable: true);

    contestJsonArray.forEach((contestJson) {
      Contest contest = Contest.fromJson(contestJson);

      if (contest.phase == 'BEFORE')
        upcomingContestArray.add(contest);
      else
        pastContestArray.add(contest);
    });

    upcomingContestArray = upcomingContestArray.reversed.toList();

    var contestArrays = [upcomingContestArray, pastContestArray];

    return contestArrays;
  }
}
