import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rendify/features/home/bloc/home_model.dart';
import 'package:rendify/shared/components/graphic.dart';

class StockList extends StatefulWidget {
  final List<WatchItem> lista;
  final Function(String symbol) function;
  final IconData icon;

  StockList({required this.lista, required this.function, required this.icon});

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  bool isGraphic = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              setState(() {
                isGraphic = !isGraphic;
              });
            },
            child: isGraphic
                ? Container(
                    height: 300,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.lista[index].symbol,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text("R\$${widget.lista[index].price}",
                            style: GoogleFonts.poppins(color: Colors.green)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: BdrChartCard(),
                        ),
                      ],
                    ),
                  )
                : ListTile(
                    title: Text(widget.lista[index].symbol),
                    subtitle: Text("${widget.lista[index].price}"),
                    trailing: IconButton(
                        onPressed: () =>
                            widget.function(widget.lista[index].symbol),
                        icon: Icon(
                          widget.icon,
                          color: Colors.black,
                        )),
                    tileColor: Color(0xFFEEEEEE),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
          ),
        );
      },
      itemCount: widget.lista.length,
    );
  }
}
