import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phone,
        imageUrl,
      ];

  // factory User.fromMap(Map map) {
  //   return User(
  //     id: map['id'],
  //     name: map['name'],
  //     email: map['email'],
  //     phone: map['phone'],
  //     imageUrl: map['imageUrl'],
  //   );
  // }

  // Map<String, Object> toMap() => {
  //       'id': this.id,
  //       'name': this.name,
  //       'email': this.email,
  //       'phone': this.phone,
  //       'imageUrl': this.imageUrl,
  //     };
}
