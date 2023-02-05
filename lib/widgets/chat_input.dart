import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/image_picker_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessage) onSubmit;
  ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();

  String _selectedImageUrl = '';

  void sendMessage() {
    final message = ChatMessage(
      id: 5,
      text: chatMessageController.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      sender: User(
        id: 1,
        username: context.read<AuthService>().getUsername(),
      ),
    );

    widget.onSubmit(message);

    if (_selectedImageUrl.isNotEmpty) {
      message.imageUrl = _selectedImageUrl;
    }

    chatMessageController.clear();
    _selectedImageUrl = '';
    setState(() {});
  }

  void onImagedPicked(String imageUrl) {
    setState(() {
      _selectedImageUrl = imageUrl;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ImagePickerBody(
                      onImageSelected: onImagedPicked,
                    );
                  });
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                if (_selectedImageUrl.isNotEmpty)
                  Image.network(
                    _selectedImageUrl,
                    height: 100,
                  ),
              ],
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
