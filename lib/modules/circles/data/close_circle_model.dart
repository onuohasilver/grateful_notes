// To parse this JSON data, do
//
//     final CloseCircleModel = CloseCircleModelFromJson(jsonString);

import 'dart:convert';

import 'package:grateful_notes/modules/circles/data/friend_model.dart';

CloseCircleModel closeCircleModelFromJson(String str) =>
    CloseCircleModel.fromJson(json.decode(str));

String closeCircleModelToJson(CloseCircleModel data) =>
    json.encode(data.toJson());

class CloseCircleModel {
  CloseCircleModel({this.friends = const []});

  final List<FriendModel> friends;

  CloseCircleModel copyWith({
    List<FriendModel>? friends,
  }) =>
      CloseCircleModel(
        friends: friends ?? this.friends,
      );

  factory CloseCircleModel.fromJson(Map<dynamic, dynamic> json) =>
      CloseCircleModel(
        friends: List<FriendModel>.from(
            (json["friends"] ?? []).map((x) => FriendModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friends": List<String>.from(friends.map((x) => x)),
      };

  factory CloseCircleModel.empty() => CloseCircleModel(friends: []);
}
