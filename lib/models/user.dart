import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letsattend/models/person.dart';

class User extends Person {

  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final String providerId;
  final bool isAnonymous;

  User({
    @required this.uid,
    this.providerId,
    this.email,
    this.name,
    this.photoUrl,
    this.isAnonymous = false,
  }) : super(name == null ? '#': name);

  @override
  factory User.fromFirebase(FirebaseUser user) => User(
    uid: user.uid,
    providerId: user.providerId,
    email: user.email,
    name: user.displayName,
    photoUrl: user.photoUrl,
    isAnonymous: user.isAnonymous,
  );

  @override
  String toString() {
    return 'User: $uid $name $email';
  }

}
