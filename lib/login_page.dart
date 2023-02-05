import 'package:chat_app/chat_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:chat_app/utils/textfield_styles.dart';
import 'package:chat_app/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String _mainUrl = 'https://www.google.com';
  final String _linkedInUrl = 'https://linkedin.com';
  final String _twitterUrl = 'https://twitter.com';

  Future<void> loginUser(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await context.read<AuthService>().loginUser(usernameController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: usernameController.text);
    } else {}
  }

  Widget _buildHeader(context) {
    return Column(
      children: [
        const Text(
          'Let\'s sign you in!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          'Welcome back! \nYou\'ve been missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
        verticalSpacing(24),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/illustration.png'),
              ),
              borderRadius: BorderRadius.circular(12)),
        ),
        verticalSpacing(24),
      ],
    );
  }

  Widget _builFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (!await launch(_mainUrl)) {
              throw Exception('Could not launch the url ');
            }
          },
          child: Column(
            children: const [
              Text('Find us on'),
              Text('App website'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Twitter,
              mini: true,
              onPressed: () async {
                if (!await launch(_twitterUrl)) {
                  throw Exception('Could not launch the url ');
                }
              },
            ),
            SignInButton(
              Buttons.LinkedIn,
              mini: true,
              onPressed: () async {
                if (!await launch(_linkedInUrl)) {
                  throw Exception('Could not launch the url ');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              LoginTextField(
                hintText: 'Username',
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 5) {
                    return "Your username must contain more than 5 characters";
                  } else if (value != null && value.isEmpty) {
                    return "Please, enter your username";
                  }

                  return null;
                },
                controller: usernameController,
              ),
              verticalSpacing(24),
              LoginTextField(
                controller: passwordController,
                hintText: 'Password',
                mustObscure: true,
              ),
            ],
          ),
        ),
        verticalSpacing(24),
        ElevatedButton(
          onPressed: () async {
            await loginUser(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeader(context),
                        _builFooter(),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildForm(context),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                _buildForm(context),
                _builFooter(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
