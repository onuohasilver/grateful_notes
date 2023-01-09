// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel? configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel? data) => json.encode(data!.toJson());

class ConfigModel {
  ConfigModel({
    required this.stickers,
  });

  final List<String?>? stickers;

  ConfigModel copyWith({
    List<String?>? stickers,
  }) =>
      ConfigModel(
        stickers: stickers ?? this.stickers,
      );

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        stickers: json["stickers"] == null
            ? []
            : List<String?>.from(json["stickers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "stickers":
            stickers == null ? [] : List<dynamic>.from(stickers!.map((x) => x)),
      };
}
