// To parse this JSON data, do
//
//     final recapModel = recapModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

RecapModel recapModelFromJson(String str) =>
    RecapModel.fromJson(json.decode(str));

String recapModelToJson(RecapModel data) => json.encode(data.toJson());

class RecapModel {
  RecapModel(
      {required this.mostCommonWord,
      required this.numberOfMoments,
      required this.timeOfDay,
      this.month});

  final String mostCommonWord;
  final int numberOfMoments;
  final String? month;
  final String timeOfDay;

  RecapModel copyWith(
          {String? mostCommonWord,
          int? numberOfMoments,
          String? timeOfDay,
          String? month}) =>
      RecapModel(
          mostCommonWord: mostCommonWord ?? this.mostCommonWord,
          numberOfMoments: numberOfMoments ?? this.numberOfMoments,
          timeOfDay: timeOfDay ?? this.timeOfDay,
          month: month ?? this.month);

  factory RecapModel.fromJson(Map<String, dynamic> json) => RecapModel(
      mostCommonWord: json["mostCommonWord"],
      numberOfMoments: json["numberOfMoments"],
      timeOfDay: json["timeOfDay"],
      month: DateFormat('MMMM')
          .format(DateTime.now().subtract(const Duration(days: 30))));

  factory RecapModel.createNew() => RecapModel(
      mostCommonWord: "",
      numberOfMoments: 12,
      timeOfDay: "Morning",
      month: DateFormat('MMMM')
          .format(DateTime.now().subtract(const Duration(days: 30))));

  Map<String, dynamic> toJson() => {
        "mostCommonWord": mostCommonWord,
        "numberOfMoments": numberOfMoments,
        "timeOfDay": timeOfDay,
        "month": month
      };
}
