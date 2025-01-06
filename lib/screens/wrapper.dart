import 'package:flutter/material.dart';
import 'package:lab_4/providers/app_provider.dart';
import 'package:lab_4/screens/authenticate/authenticate_screen.dart';
import 'package:lab_4/screens/home/home_screen.dart';
import 'package:lab_4/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ApplicationProvider>().user;

    return Scaffold(
      appBar: const MyAppBar(),
      body: user.id == "" ? const Authenticate() : Home(),
    );
  }
}
