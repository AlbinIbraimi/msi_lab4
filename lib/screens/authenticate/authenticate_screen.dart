import 'package:flutter/material.dart';
import 'package:lab_4/screens/authenticate/register_screen.dart';
import 'package:lab_4/screens/authenticate/sign_in_screen.dart';
import 'package:lab_4/services/auth_service.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthServiceProvider>(context);

    return authProvider.showSignIn ? const SignIn() : const Register();
  }
}
