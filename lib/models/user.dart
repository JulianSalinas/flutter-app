class User {

  final String email;
  final String username;
  final String photoUrl;

  User({
    this.email,
    this.username,
    this.photoUrl,
  });

  @override
  String toString() {
    return 'User: $username $email';
  }

}
