// To parse this JSON data, do
//
//     final gratitudeEditModel = gratitudeEditModelFromJson(jsonString);

import 'dart:convert';

// GratitudeEditModel gratitudeEditModelFromJson(String str) =>
// GratitudeEditModel.fromJson(json.decode(str));

String gratitudeEditModelToJson(GratitudeEditModel data) =>
    json.encode(data.toJson());

class GratitudeEditModel {
  GratitudeEditModel(
      {required this.texts,
      required this.imagePaths,
      required this.date,
      required this.type,
      this.name,
      required this.id,
      required this.privacy});

  final List<String> texts;
  final List<String> imagePaths;
  final DateTime date;
  final String type;
  final String? name;
  final String? privacy;
  final String id;

  GratitudeEditModel copyWith(
          {List<String>? texts,
          List<String>? imagePaths,
          String? name,
          String? privacy}) =>
      GratitudeEditModel(
          type: type,
          texts: texts ?? this.texts,
          imagePaths: imagePaths ?? this.imagePaths,
          name: name ?? this.name,
          id: id,
          privacy: privacy ?? this.privacy,
          date: date);

  factory GratitudeEditModel.fromJson(Map<String, dynamic> json, String id) =>
      GratitudeEditModel(
          type: json['type'],
          id: id,
          privacy: json['Privacy'] ?? "Open",
          texts: List<String>.from(json["texts"].map((x) => x)),
          imagePaths: List<String>.from(json["imagePaths"].map((x) => x)),
          date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "id": id,
        "privacy": privacy,
        "texts": List<dynamic>.from(texts.map((x) => x)),
        "imagePaths": List<dynamic>.from(imagePaths.map((x) => x)),
      };

  factory GratitudeEditModel.createNew(String type) => GratitudeEditModel(
      texts: [""],
      imagePaths: [],
      date: DateTime.now(),
      type: type,
      id: "",
      privacy: "Open");

  @override
  String toString() {
    return toJson().toString();
  }
}
