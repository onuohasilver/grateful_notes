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

  final List<String> friends;

  CloseCircleModel copyWith({
    List<String>? friends,
  }) =>
      CloseCircleModel(
        friends: friends ?? this.friends,
      );

  factory CloseCircleModel.fromJson(Map<dynamic, dynamic> json) =>
      CloseCircleModel(
        friends: List<String>.from(json["friends"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "friends": List<String>.from(friends.map((x) => x)),
      };

  factory CloseCircleModel.empty() => CloseCircleModel(friends: []);
}
