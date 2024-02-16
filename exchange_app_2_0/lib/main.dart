import 'package:exchange_app_2_0/responsive/mobile_screen_layout.dart';
import 'package:exchange_app_2_0/responsive/responsive_screen.dart';
import 'package:exchange_app_2_0/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveLayout(webScreenLayout: const WebScreenLayout(), mobileScreenLayout: MobileScreenLayout(),),
    );
  }
}

