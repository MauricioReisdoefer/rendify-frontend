import 'package:flutter/material.dart';
import 'package:rendify/shared/components/appbar.dart';
import 'package:rendify/features/search/presentation/screen/search.dart';
import 'package:rendify/features/simulator/screen/simulator.dart';
import 'duvidas_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rendify/features/home/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  Widget body;
  final String? username;

  @override
  State<MainScreen> createState() => _MainScreenState();

  MainScreen({super.key, required this.body, this.username});
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      HomeScreen(),
      SearchPage(),
      SimulatorScreen(
        username: widget.username!,
      ),
      DuvidasFrequentesPage(),
    ];
    return Scaffold(
      appBar: CustomAppBar(),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            widget.body = widgets[index];
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Buscar'.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Simulador'.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline), label: 'Dúvidas'.tr()),
        ],
      ),
    );
  }
}
