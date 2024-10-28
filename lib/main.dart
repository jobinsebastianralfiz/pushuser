import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pushuser/firebase_options.dart';
import 'package:pushuser/screens/offerscreen.dart';
import 'package:pushuser/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OfferScreen(),
    );
  }
}
