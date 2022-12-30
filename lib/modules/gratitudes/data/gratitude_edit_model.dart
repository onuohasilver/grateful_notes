// To parse this JSON data, do
//
//     final gratitudeEditModel = gratitudeEditModelFromJson(jsonString);

import 'dart:convert';

GratitudeEditModel gratitudeEditModelFromJson(String str) =>
    GratitudeEditModel.fromJson(json.decode(str));

String gratitudeEditModelToJson(GratitudeEditModel data) =>
    json.encode(data.toJson());

class GratitudeEditModel {
  GratitudeEditModel(
      {required this.texts,
      required this.imagePaths,
      required this.date,
      required this.type});

  final List<String> texts;
  final List<String> imagePaths;
  final DateTime date;
  final String type;

  GratitudeEditModel copyWith({
    List<String>? texts,
    List<String>? imagePaths,
  }) =>
      GratitudeEditModel(
          type: type,
          texts: texts ?? this.texts,
          imagePaths: imagePaths ?? this.imagePaths,
          date: DateTime.now());

  factory GratitudeEditModel.fromJson(Map<String, dynamic> json) =>
      GratitudeEditModel(
          type: json['type'],
          texts: List<String>.from(json["texts"].map((x) => x)),
          imagePaths: List<String>.from(json["imagePaths"].map((x) => x)),
          date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "texts": List<dynamic>.from(texts.map((x) => x)),
        "imagePaths": List<dynamic>.from(imagePaths.map((x) => x)),
      };

  factory GratitudeEditModel.createNew(String type) => GratitudeEditModel(
        texts: [""],
        imagePaths: [],
        date: DateTime.now(),
        type: type
      );

  @override
  String toString() {
    return toJson().toString();
  }
}
