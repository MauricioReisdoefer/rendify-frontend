import 'package:flutter/material.dart';
import 'package:rendify/screens/login_screen.dart'; // Caminho correto para o CustomAppBar

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginCadastroPage(),
    );
  }
}
