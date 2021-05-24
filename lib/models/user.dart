import 'package:letsattend/models/person.dart';

class AppUser extends Person {

  final String key;
  final String name;

  final String? email;
  final String? photoUrl;

  bool allowPhoto;
  bool isAdmin;
  bool isLogged;

  final bool isAnonymous;

  AppUser({
    required this.key,
    this.name = "unknown",
    this.email,
    this.photoUrl,
    this.allowPhoto = true,
    this.isAdmin = true,
    this.isLogged = false,
    this.isAnonymous = false,
  }) : super(name);

  toJson() => ({
    'userid': key,
    'username': name,
    'email': email,
    'allowPhoto': allowPhoto,
  });

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AppUser && key == other.key;
  }

  @override
  String toString() {
    return 'User{ name: $name, email: $email }';
  }


}
