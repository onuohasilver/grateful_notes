// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
  const UserModel({
    required this.email,
    required this.username,
    required this.userid,
  });

  final String email;
  final String username;
  final String userid;

  UserModel copyWith({
    String? name,
    String? email,
    String? username,
    String? userid,
  }) =>
      UserModel(
        email: email ?? this.email,
        username: username ?? this.username,
        userid: userid ?? this.userid,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        username: json["username"],
        userid: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "id": userid,
      };

  bool isMatch(UserModel um) => um == this;

  FriendModel toFriendModel() {
    return FriendModel(
        name: username, id: userid, accepted: false, senderId: userid);
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [username, userid, email];
}
