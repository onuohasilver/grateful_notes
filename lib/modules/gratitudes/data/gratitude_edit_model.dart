// To parse this JSON data, do
//
//     final gratitudeEditModel = gratitudeEditModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// GratitudeEditModel gratitudeEditModelFromJson(String str) =>
// GratitudeEditModel.fromJson(json.decode(str));

String gratitudeEditModelToJson(GratitudeEditModel data) =>
    json.encode(data.toJson());

class GratitudeEditModel extends Equatable {
  const GratitudeEditModel(
      {required this.texts,
      required this.imagePaths,
      required this.date,
      required this.type,
      required this.delete,
      this.stickers,
      this.name,
      this.audio,
      this.audioDuration,
      required this.id,
      required this.privacy});

  final List<String> texts;
  final List<String> imagePaths;
  final List<String>? stickers;
  final DateTime date;
  final String type;
  final String? name;
  final String? privacy;
  final String id;
  final String? audio;
  final int? audioDuration;
  final bool delete;

  GratitudeEditModel copyWith(
          {List<String>? texts,
          List<String>? imagePaths,
          String? name,
          bool? delete,
          String? audio,
          int? audioDuration,
          List<String>? stickers,
          String? privacy}) =>
      GratitudeEditModel(
          type: type,
          audioDuration: audioDuration ?? this.audioDuration,
          texts: texts ?? this.texts,
          imagePaths: imagePaths ?? this.imagePaths,
          name: name ?? this.name,
          id: id,
          audio: audio ?? this.audio,
          privacy: privacy ?? this.privacy,
          stickers: stickers ?? this.stickers,
          delete: delete ?? this.delete,
          date: date);

  factory GratitudeEditModel.fromJson(Map<String, dynamic> json, String id) =>
      GratitudeEditModel(
          type: json['type'],
          id: id,
          audioDuration: json['audioDuration'],
          audio: json['audio'],
          stickers: json["stickers"] ?? [],
          delete: json['delete'] ?? false,
          privacy: json['Privacy'] ?? "Open",
          texts: List<String>.from(json["texts"].map((x) => x)),
          imagePaths: List<String>.from(json["imagePaths"].map((x) => x)),
          date: DateTime.parse(json['date']));

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "id": id,
        "audio": audio,
        "privacy": privacy,
        "delete": delete,
        "audioDuration": audioDuration,
        "texts": List<dynamic>.from(texts.map((x) => x)),
        "imagePaths": List<dynamic>.from(imagePaths.map((x) => x)),
      };

  factory GratitudeEditModel.createNew(String type) => GratitudeEditModel(
      texts: const [""],
      imagePaths: const [],
      date: DateTime.now(),
      stickers: const [],
      type: type,
      id: "",
      audioDuration: null,
      delete: false,
      audio: null,
      privacy: "Open");

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [texts];
}
