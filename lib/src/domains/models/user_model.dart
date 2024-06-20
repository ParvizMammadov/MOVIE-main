import 'dart:io';

import 'package:flutter/material.dart';

class User {
  String name;
  String surname;
  String age;
  String gender;
  File image;

  User({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
    required this.image,
  });

  User copyWith({
    String? name,
    String? surname,
    String? age,
    String? gender,
    File? image,
  }) {
    return User(
        image: image ?? this.image,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        age: age ?? this.age,
        gender: gender ?? this.gender);
  }
}
