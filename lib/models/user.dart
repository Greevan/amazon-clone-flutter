import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
  });

  // Generate JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  // Factory constructor to create a User object from a JSON map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      name: map['name'],
      password: map['password'],
      address: map['address'],
      type: map['type'], // <- Add the missing required parameter
      token: map['token'],
    );
  }

  // Serialize the User object to a JSON string
  String toJson() => json.encode(toMap()); // <- Change the return type to string

  // Factory constructor to create a User object from a JSON string
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}