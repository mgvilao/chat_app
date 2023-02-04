class User {
  int id;
  String username;

  User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> senderJson) {
    return User(id: senderJson['id'], username: senderJson['username']);
  }
}
