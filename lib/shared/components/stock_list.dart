import 'package:flutter/material.dart';
import 'package:rendify/features/home/bloc/home_model.dart';

class StockList extends StatelessWidget {
  final List<WatchItem> lista;
  final Function(String symbol) function;
  final IconData icon;

  StockList({required this.lista, required this.function, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(lista[index].symbol),
            subtitle: Text("${lista[index].price}"),
            trailing: IconButton(
                onPressed: () => function(lista[index].symbol),
                icon: Icon(
                  icon,
                  color: Colors.black,
                )),
            tileColor: Color(0xFFEEEEEE),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        );
      },
      itemCount: lista.length,
    );
  }
}
