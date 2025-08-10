import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BdrChartCard extends StatelessWidget {
  const BdrChartCard({super.key});
  @override
  Widget build(BuildContext context) {
    return LineChart(
    LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                "${spot.y.toInt().toString()},00",
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();}
        ),
      ),
      minX: 5,
      maxX: 15,
      minY: 0,
      maxY: 200,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(5, 30),
            FlSpot(6, 50),
            FlSpot(7, 80),
            FlSpot(8, 100),
            FlSpot(9, 90),
            FlSpot(10, 120),
            FlSpot(11, 95),
            FlSpot(12, 130),
            FlSpot(13, 110),
            FlSpot(14, 150),
            FlSpot(15, 200)],
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
                Colors.indigo.withOpacity(0.1),],
            ),
          ),
        ),
      ],
    ),
  );
  }
}