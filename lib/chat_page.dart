import 'package:chat_app/models/User.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final List<ChatMessage> _messages = [
    ChatMessage(
      id: 1,
      text: 'Hi',
      createdAt: 20230204,
      sender: User(id: 1, username: 'mgvilao'),
    ),
    ChatMessage(
      id: 2,
      text: 'Heyyy',
      createdAt: 20230204,
      sender: User(id: 2, username: 'ednasvilao'),
    ),
    ChatMessage(
      id: 1,
      text: 'Here\'s what I\' up to',
      createdAt: 20230204,
      imageUrl: 'https://picsum.photos/250?image=9',
      sender: User(id: 1, username: 'mgvilao'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Hello $username',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
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
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _messages[index].sender.username == 'mgvilao'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  message: _messages[index],
                );
              },
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
