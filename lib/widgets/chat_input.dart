import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessage) onSubmit;
  ChatInput({super.key, required this.onSubmit});

  final chatMessageController = TextEditingController();

  void sendMessage() {
    final message = ChatMessage(
      id: 5,
      text: chatMessageController.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      sender: User(id: 1, username: 'mgvilao'),
    );

    onSubmit(message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              controller: chatMessageController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
