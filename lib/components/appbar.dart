import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      title: Row(
        children: [
          const Icon(
            Icons.auto_graph,
            size: 40,
            color: Colors.white,
          ),
          Text("Rendify",
              style: GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
        ],
      ),
      centerTitle: true,
    );
  }
}
