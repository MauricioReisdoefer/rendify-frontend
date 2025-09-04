import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BdrChartCard extends StatefulWidget {
  final String symbol;

  const BdrChartCard({super.key, required this.symbol});

  @override
  _BdrChartCardState createState() => _BdrChartCardState();
}

class _BdrChartCardState extends State<BdrChartCard> {
  List<double>? values;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGraphData();
  }

  Future<void> fetchGraphData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      final response = await http.get(
        Uri.parse("${dotenv.get("API_URL")}/stock/graph/${widget.symbol}/24"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          values = data
              .map((e) => double.tryParse(e['close'].toString()) ?? 0)
              .toList()
              .reversed
              .toList(); // ordem cronológica
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || values == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < values!.length; i++) {
      spots.add(FlSpot(i.toDouble(), values![i]));
    }

    final minPrice = values!.reduce((a, b) => a < b ? a : b);
    final maxPrice = values!.reduce((a, b) => a > b ? a : b);
    final margin = (maxPrice - minPrice) * 0.1;

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 6, // a cada 6 pontos
              getTitlesWidget: (value, meta) {
                final totalPoints = values!.length - 1;
                // 0 → esquerda = 24h, totalPoints → direita = agora
                if (value.toInt() == 0) return const Text("24h", style: TextStyle(fontSize: 12));
                if (value.toInt() == totalPoints) return const Text("Agora", style: TextStyle(fontSize: 12));
                if (value.toInt() % 6 == 0) return Text("${24 - value.toInt()}h", style: const TextStyle(fontSize: 12));
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (values!.length - 1).toDouble(),
        minY: minPrice - margin,
        maxY: maxPrice + margin,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.indigo,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.withOpacity(0.4),
                  Colors.indigo.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  spot.y.toStringAsFixed(2),
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
