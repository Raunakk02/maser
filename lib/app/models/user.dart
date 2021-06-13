import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String phone;
  String imageUrl;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.imageUrl,
  });

  factory User.fromMap(Map map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, Object> toMap() => {
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'phone': this.phone,
        'imageUrl': this.imageUrl,
      };
}
