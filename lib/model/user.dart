import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AppUser userFromJson(String str) => AppUser.fromJson(json.decode(str));

String userToJson(AppUser data) => json.encode(data.toJson());

class AppUser {


  AppUser({
    required this.id,
    this.userId,
    this.name,
    this.familyName,
    this.email,
    this.image,
    this.username
  });

  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic familyName;
  dynamic email;
  dynamic image;
  dynamic username;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
      id: json["id"].toString(),
      userId: json["userId"].toString(),
      name: json["name"].toString(),
      email: json["email"].toString(),
      familyName: json["familyName"].toString(),
      image: json["image"].toString(),
      username: json["username"].toString()

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "name": name,
    "email": email,
    "familyName": familyName,
    "image": image,
    "username": username
  };

}

