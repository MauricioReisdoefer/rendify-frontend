import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rendify/shared/components/graphic.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _controller = TextEditingController();
  double preco = 1905.00;
  int estoque = 100;

  List<FlSpot> pontos = [
    const FlSpot(0, 20),
    const FlSpot(1, 30),
    const FlSpot(2, 60),
    const FlSpot(3, 50),
    const FlSpot(4, 90),
    const FlSpot(5, 150),
    const FlSpot(6, 120),
    const FlSpot(7, 160),
    const FlSpot(8, 180),
    const FlSpot(9, 150),
    const FlSpot(10, 110),
    const FlSpot(11, 170),
    const FlSpot(12, 180),
    const FlSpot(13, 180),
    const FlSpot(14, 150),
    const FlSpot(15, 120),
    const FlSpot(17, 160),
    const FlSpot(18, 180),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Color(0xFFEEEEEE), borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amazon.com Inc. BDR",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("AMZO34",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 12),
                  
                      Text(
                        "Interações",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Interaja com suas Ações da ",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Amazon.com Inc. BDR",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                  
                      // Card do gráfico
                      Container(
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
                            Text("Amazon.com Inc. BDR",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("R\$17,81  •  2,1% ↑ R\$3,11",
                                style: GoogleFonts.poppins(color: Colors.green)),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 200,
                              child: BdrChartCard(),
                            ),
                          ],
                        ),
                      ),
                  
                      const SizedBox(height: 16),
                  
                      Text(
                        "Preço: R\$${preco.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      Text(
                        "Estoque: $estoque Ações",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.blue),
                      ),
                  
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(1, 70),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text("Comprar",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(1, 70),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text("Vender",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Digite a quantidade a ser vendida/comprada...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

