import 'package:chat_app/models/User.dart';

class ChatMessage {
  int id;
  String text;
  String? imageUrl;
  int createdAt;
  User sender;

  ChatMessage(
      {required this.id,
      required this.text,
      required this.createdAt,
      required this.sender,
      this.imageUrl});
}
