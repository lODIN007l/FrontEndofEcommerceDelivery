// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String name;
  String lastname;
  String email;
  String phone;
  String? password;
  String? sessionToken;
  String? image;

  User(
      {this.id,
      required this.email,
      required this.name,
      required this.lastname,
      required this.phone,
      this.image,
      this.password,
      this.sessionToken});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        //password: json["password"],
        sessionToken: json["session_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "session_token": sessionToken,
      };
}
