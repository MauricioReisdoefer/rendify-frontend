import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchPage extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                hintText: "Buscar".tr(),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0)),
                suffix: Icon(Icons.search),
              ),
              onChanged: (value) {},
            ),
          ),
          Center(child: Text("Nenhuma pesquisa feita".tr()))
        ],
      ),
    );
  } 
}