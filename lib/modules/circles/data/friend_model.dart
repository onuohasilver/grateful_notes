// To parse this JSON data, do
//
//     final friendModel = friendModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

FriendModel friendModelFromJson(String str) =>
    FriendModel.fromJson(json.decode(str));

String friendModelToJson(FriendModel data) => json.encode(data.toJson());

class FriendModel extends Equatable {
  const FriendModel({
    required this.name,
    required this.id,
    required this.accepted,
    required this.senderId,
    required this.notificationId,
  });

  final String name;
  final String id, senderId, notificationId;
  final bool accepted;

  FriendModel copyWith(
          {String? name,
          String? id,
          bool? accepted,
          String? senderId,
          String? notificationId}) =>
      FriendModel(
          name: name ?? this.name,
          id: id ?? this.id,
          accepted: accepted ?? this.accepted,
          notificationId: notificationId ?? this.notificationId,
          senderId: senderId ?? this.senderId);

  factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
      name: json["name"],
      id: json["id"],
      accepted: json["accepted"],
      notificationId: json["notificationId"] ?? json["notificationid"] ?? "",
      senderId: json['senderId']);
  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "accepted": accepted,
        "senderId": senderId,
        "notificationId": notificationId
      };

  @override
  List<Object?> get props => [id, senderId];
}
