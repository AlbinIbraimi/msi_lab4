import 'package:flutter/material.dart';
import 'package:lab_4/services/auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthServiceProvider>(context);

    return ElevatedButton(
        onPressed: () async {
          await authService.signout();
        },
        child: const Text("Sign out"));
  }
}
