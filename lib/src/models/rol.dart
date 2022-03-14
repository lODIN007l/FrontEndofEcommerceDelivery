// To parse this JSON data, do
//
//     final rol = rolFromJson(jsonString);

import 'dart:convert';

List<Rol> rolFromJson(String str) =>
    List<Rol>.from(json.decode(str).map((x) => Rol.fromJson(x)));

String rolToJson(List<Rol> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rol {
  Rol({
    this.id,
    this.name,
    this.image,
    required this.route,
  });

  String? id;
  String? name;
  String? image;
  String route;

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"] is int ? json['id'].toString() : json["id"],
        name: json["name"],
        image: json["image"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "route": route,
      };
}
