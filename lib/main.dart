import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab_4/firebase_options.dart';
import 'package:lab_4/providers/app_provider.dart';
import 'package:lab_4/screens/home/calendar_screen.dart';
import 'package:lab_4/screens/home/exam_details_screen.dart';
import 'package:lab_4/screens/wrapper.dart';
import 'package:lab_4/services/auth_service.dart';
import 'package:lab_4/services/storage_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ApplicationProvider>(
        create: (_) => ApplicationProvider()),
    ChangeNotifierProvider<AuthServiceProvider>(
        create: (_) => AuthServiceProvider()),
    ChangeNotifierProvider<StorageServiceProvider>(
        create: (_) => StorageServiceProvider())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => const Wrapper(),
        '/calendar': (context) => const Calendar(),
        '/details': (context) => const DetailsExam()
      },
    );
  }
}
