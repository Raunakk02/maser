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
}

class UserModel extends User {
  UserModel({
    @required String id,
    @required String name,
    @required String email,
    @required String phone,
    @required String imageUrl,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          imageUrl: imageUrl,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'phone': this.phone,
        'imageUrl': this.imageUrl,
      };
}
