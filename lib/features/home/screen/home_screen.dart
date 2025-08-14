import 'package:flutter/material.dart';
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