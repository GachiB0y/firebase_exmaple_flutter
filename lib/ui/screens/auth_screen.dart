import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/service/firebase_service.dart';
import 'package:flutter_firebase/ui/widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = false;
  final FirebaseService firebaseService = FirebaseService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onAuth = isLogin ? () => firebaseService.onLogin(email:emailController.text ,password:passwordController.text) :()=> firebaseService.onRegister(email:emailController.text ,password:passwordController.text);
    final buttonText = isLogin ? 'Login' : 'Register';

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase ${buttonText}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthForm(
              authButtonText: buttonText,
              onAuth: onAuth,
              emailController: emailController,
              passwordController: passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(buttonText),
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                ),
                Icon(Icons.reply_all),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
