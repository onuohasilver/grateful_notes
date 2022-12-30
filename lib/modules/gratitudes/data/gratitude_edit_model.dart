// To parse this JSON data, do
//
//     final gratitudeEditModel = gratitudeEditModelFromJson(jsonString);

import 'dart:convert';

GratitudeEditModel gratitudeEditModelFromJson(String str) =>
    GratitudeEditModel.fromJson(json.decode(str));

String gratitudeEditModelToJson(GratitudeEditModel data) =>
    json.encode(data.toJson());

class GratitudeEditModel {
  GratitudeEditModel({
    required this.texts,
    required this.imagePaths,
  });

  final List<String> texts;
  final List<String> imagePaths;

  GratitudeEditModel copyWith({
    List<String>? texts,
    List<String>? imagePaths,
  }) =>
      GratitudeEditModel(
        texts: texts ?? this.texts,
        imagePaths: imagePaths ?? this.imagePaths,
      );

  factory GratitudeEditModel.fromJson(Map<String, dynamic> json) =>
      GratitudeEditModel(
        texts: List<String>.from(json["texts"].map((x) => x)),
        imagePaths: List<String>.from(json["imagePaths"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "texts": List<dynamic>.from(texts.map((x) => x)),
        "imagePaths": List<dynamic>.from(imagePaths.map((x) => x)),
      };

  factory GratitudeEditModel.createNew() =>
      GratitudeEditModel(texts: [""], imagePaths: []);

  @override
  String toString() {
    return toJson().toString();
  }
}
