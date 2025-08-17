import 'package:flutter/material.dart';
import 'package:rendify/features/home/bloc/home_model.dart';

class StockList extends StatelessWidget {
  final List<WatchItem> lista;

  StockList(this.lista);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(lista[index].symbol),
            subtitle: Text("${lista[index].price}"),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.star)),
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
