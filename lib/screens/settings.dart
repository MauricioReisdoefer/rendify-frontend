import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: DropdownButton<Locale>(value: context.locale, items: [DropdownMenuItem(child: Text("Português"), value: Locale('pt','BR'),), DropdownMenuItem(child: Text("English"), value: Locale('en','US'),), DropdownMenuItem(child: Text("Español"), value: Locale('es','MEX'),)],
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          context.setLocale(newLocale);
        }
      },
      ),
    );
  }
}