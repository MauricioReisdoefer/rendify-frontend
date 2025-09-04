import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rendify/features/home/bloc/home_model.dart';
import 'package:rendify/shared/components/graphic.dart';

class StockList extends StatefulWidget {
  final List<WatchItem> lista;
  final Function(String symbol) function;
  final IconData icon;

  StockList({
    required this.lista,
    required this.function,
    required this.icon,
  });

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  bool isGraphic = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.lista.length,
        itemBuilder: (context, index) {
          final item = widget.lista[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isGraphic = !isGraphic;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5), // Glassy
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: isGraphic
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.symbol,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "R\$${item.price}",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.white.withOpacity(0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                                  child: BdrChartCard(symbol: item.symbol),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListTile(
                        title: Text(
                          item.symbol,
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "R\$${item.price}",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () => widget.function(item.symbol),
                          icon: Icon(
                            widget.icon,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}