import 'package:letsattend/models/person.dart';

class User extends Person {

  final String key;
  final String name;
  final String email;
  final String photoUrl;

  bool allowPhoto;
  final bool isAnonymous;

  User({
    this.key,
    this.name,
    this.email,
    this.photoUrl,
    this.allowPhoto = true,
    this.isAnonymous = false,
  }) : super(name == null ? '#': name);

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
    return identical(this, other) || other is User && key == other.key;
  }

  @override
  String toString() {
    return 'User{ name: $name, email: $email }';
  }


}
