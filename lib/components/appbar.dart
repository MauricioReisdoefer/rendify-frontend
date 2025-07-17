import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF2196F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/logopi.png', height: 40),
              const SizedBox(height: 8),
              const Text(
                'Rendify',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),],),)
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(120);
}
