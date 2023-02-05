import 'package:chat_app/chat_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(Provider(
    create: (context) => AuthService(),
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
        ),
      ),
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return ChatPage();
            } else {
              return LoginPage();
            }
          }

          return const CircularProgressIndicator();
        },
      ),
      routes: {
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
