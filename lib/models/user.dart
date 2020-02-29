import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letsattend/models/person.dart';

class User extends Person {

  final String id;
  final String email;
  final String name;
  final String photoUrl;
  final bool isAnonymous;

  User({
    @required this.id,
    this.email,
    this.name,
    this.photoUrl,
    this.isAnonymous = false,
  }) : super(name == null ? '#': name);

  toJson() {
    return {
      'allowPhoto': true,
      'email': email,
      'userid': id,
      'username': name,
    };
  }

  @override
  String toString() {
    return 'User: $id $name $email';
  }

}
