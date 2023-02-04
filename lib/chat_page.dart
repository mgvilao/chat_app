import 'dart:convert';
import 'package:chat_app/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> _messages = [];

  _loadInitialMessages() async {
    rootBundle.loadString('assets/mock_messages.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;
      final List<ChatMessage> chatMessages = decodedList.map((listIem) {
        return ChatMessage.fromJson(listIem);
      }).toList();

      setState(() {
        _messages = chatMessages;
      });
    });
  }

  onMessageSent(ChatMessage message) {
    _messages.add(message);
    setState(() {});
  }

  Future<List<ImageModel>> _getNetworkImages() async {
    var endpoint = Uri.parse('https://pixelford.com/api2/images');
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;
      final List<ImageModel> networkImages = decodedList.map((listIem) {
        return ImageModel.fromJson(listIem);
      }).toList();

      return networkImages;
    }

    throw Exception('Call to API failed!');
  }

  @override
  void initState() {
    _getNetworkImages();
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getNetworkImages();
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
          FutureBuilder<List<ImageModel>>(
              future: _getNetworkImages(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ImageModel>> snapshot) {
                if (snapshot.hasData) {
                  return Image.network(snapshot.data![0].urlSmallSize);
                }
                return const CircularProgressIndicator();
              }),
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
          ChatInput(
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
