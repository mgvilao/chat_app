import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Let\'s sign you in!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
              'Welcome back! \nYou\'ve been missed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            Image.network(
              'https://picsum.photos/250?image=9',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
