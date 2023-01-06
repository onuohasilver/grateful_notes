// To parse this JSON data, do
//
//     final CloseCircleModel = CloseCircleModelFromJson(jsonString);

import 'dart:convert';

CloseCircleModel closeCircleModelFromJson(String str) =>
    CloseCircleModel.fromJson(json.decode(str));

String closeCircleModelToJson(CloseCircleModel data) =>
    json.encode(data.toJson());

class CloseCircleModel {
  CloseCircleModel({required this.friends});

  final List<dynamic> friends;

  CloseCircleModel copyWith({
    List<String>? friends,
  }) =>
      CloseCircleModel(
        friends: friends ?? this.friends,
      );

  factory CloseCircleModel.fromJson(Map<String, dynamic> json) =>
      CloseCircleModel(
        friends: List<dynamic>.from(json["friends"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "friends": List<dynamic>.from(friends.map((x) => x)),
      };
}
