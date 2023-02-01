import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Hello Mike',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Logging out');
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const ChatBubble(
                  alignment: Alignment.centerLeft,
                  message: 'Hello there',
                ),
                const ChatBubble(
                  alignment: Alignment.centerRight,
                  message: 'Hello yourself',
                ),
              ],
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}
