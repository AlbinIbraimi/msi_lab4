import 'package:flutter/material.dart';
import 'package:lab_4/services/auth_service.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthServiceProvider>(context);

    return AppBar(
      backgroundColor: Colors.green,
      title: const Text(
        "181171",
      ),
      actions: [
        if (authProvider.showSignIn == false)
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              authProvider.toggleSignIn();
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
