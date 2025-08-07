import 'package:flutter/material.dart';
import 'package:rendify/shared/components/appbar.dart';
import 'package:rendify/features/search/presentation/screen/search.dart';
import 'package:rendify/to-do/screens/simulator.dart';
import 'duvidas_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget{
  Widget body;

  @override
  State<MainScreen> createState() => _MainScreenState();

  MainScreen({super.key, required this.body});
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> widgets = [HomeScreen(), SearchPage(), SimulatorScreen(), DuvidasFrequentesPage(),];


 @override
  Widget build(BuildContext context) {
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Simulador'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Dúvidas'.tr()),
        ],),
    );
  }
}

class HomeScreen extends StatelessWidget{
  List lista = ["Moeda 1", "Moeda 2", "Moeda 3"];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(title: Text(lista[index]), subtitle: Text("MDA"), trailing: Icon(Icons.star), tileColor: Color(0xFFEEEEEE), shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),),
        );
      },
      itemCount: lista.length,
      ),
    );
  }
}