import 'package:flutter/material.dart';
import 'package:lab_4/screens/authenticate/authenticate_screen.dart';
import 'package:lab_4/screens/home/home_screen.dart';
import 'package:lab_4/services/auth_service.dart';
import 'package:lab_4/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthServiceProvider>();

    return Scaffold(
      appBar: const MyAppBar(),
      body: authService.user == null ? const Authenticate() : const Home(),
    );
  }
}
