import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      centerTitle: true,
      title: Image.asset("logo.png", height: 80),
      flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[Color(0xff225DC2), Color(0xff5F72D9)]),
    )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}