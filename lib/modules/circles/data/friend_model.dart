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
  });

  final String name;
  final String id;
  final bool accepted;

  FriendModel copyWith({
    String? name,
    String? id,
    bool? accepted,
  }) =>
      FriendModel(
        name: name ?? this.name,
        id: id ?? this.id,
        accepted: accepted ?? this.accepted,
      );

  factory FriendModel.fromJson(Map<String, dynamic> json) => FriendModel(
        name: json["name"],
        id: json["id"],
        accepted: json["accepted"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "accepted": accepted,
      };

  @override
  List<Object?> get props => [id];
}
