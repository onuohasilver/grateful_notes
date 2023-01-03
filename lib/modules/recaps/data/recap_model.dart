// To parse this JSON data, do
//
//     final recapModel = recapModelFromJson(jsonString);

import 'dart:convert';

RecapModel recapModelFromJson(String str) =>
    RecapModel.fromJson(json.decode(str));

String recapModelToJson(RecapModel data) => json.encode(data.toJson());

class RecapModel {
  RecapModel({
    required this.mostCommonWord,
    required this.numberOfMoments,
    required this.timeOfDay,
  });

  final String mostCommonWord;
  final int numberOfMoments;
  final String timeOfDay;

  RecapModel copyWith({
    String? mostCommonWord,
    int? numberOfMoments,
    String? timeOfDay,
  }) =>
      RecapModel(
        mostCommonWord: mostCommonWord ?? this.mostCommonWord,
        numberOfMoments: numberOfMoments ?? this.numberOfMoments,
        timeOfDay: timeOfDay ?? this.timeOfDay,
      );

  factory RecapModel.fromJson(Map<String, dynamic> json) => RecapModel(
        mostCommonWord: json["mostCommonWord"],
        numberOfMoments: json["numberOfMoments"],
        timeOfDay: json["timeOfDay"],
      );

  factory RecapModel.createNew() => RecapModel(
      mostCommonWord: "Cjhairm as", numberOfMoments: 12, timeOfDay: "Morning");

  Map<String, dynamic> toJson() => {
        "mostCommonWord": mostCommonWord,
        "numberOfMoments": numberOfMoments,
        "timeOfDay": timeOfDay,
      };
}
