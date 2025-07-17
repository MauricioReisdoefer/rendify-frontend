import 'package:flutter/material.dart';
import 'components/appbar.dart'; // Caminho correto para o CustomAppBar

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
      appBar: const CustomAppBar(), 
      body: const Center(
        child: Text('Conteúdo da página'),
      ),
    );
  }
}
