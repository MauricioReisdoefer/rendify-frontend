import 'package:flutter/material.dart';
import 'package:rendify/components/appbar.dart';
import 'duvidas_screen.dart';

class MainScreen extends StatefulWidget{
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> widgets = [HomeScreen(), DuvidasFrequentesPage(), HomeScreen(), DuvidasFrequentesPage(),];
  Widget body = HomeScreen();


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              body = widgets[index];
            });
          },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Simulador'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'Dúvidas'),
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