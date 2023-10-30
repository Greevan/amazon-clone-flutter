import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "address": this.address,
      "type": this.type,
      "token": this.token,
    };
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      password: json["password"],
      address: json["address"],
      type: json["type"],
      token: json["token"],
      email: json["email"],
    );
  }




}