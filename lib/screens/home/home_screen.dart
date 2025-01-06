import 'package:flutter/material.dart';
import 'package:lab_4/services/auth_service.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await authService.signout();
        },
        child: const Text("Sign out"));
  }
}
