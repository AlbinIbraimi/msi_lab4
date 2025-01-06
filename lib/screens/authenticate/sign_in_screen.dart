import 'package:flutter/material.dart';
import 'package:lab_4/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: ElevatedButton(
          onPressed: () async {
            await authService.signInAnno();
          },
          child: const Text("Sign in")),
    );
  }
}
