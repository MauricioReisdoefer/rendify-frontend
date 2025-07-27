import 'package:flutter/material.dart';
import 'package:rendify/components/appbar.dart';
import 'package:rendify/screens/login_screen.dart';
import 'package:rendify/screens/main_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: LoginCadastroPage(),
      );
  }
}
