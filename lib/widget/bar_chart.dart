import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AllergenBarChart extends StatelessWidget {
  final List<String> labels = [
    "Vegan", "Vegetarian", "Kosher", "Halal", "Keto", "Others"
  ];
  final List<int> values = [3, 6, 9, 5, 3, 4];
  final List<Color> colors = [
    Colors.green,
    Colors.lightGreen,
    Colors.orange,
    Colors.greenAccent,
    Colors.cyan,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '32 Allergens Found',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      int index = value.toInt();
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(labels[index], style: const TextStyle(fontSize: 12)),
                      );
                    },
                    reservedSize: 32,
                  ),
                ),
              ),
              barGroups: List.generate(values.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: values[index].toDouble(),
                      color: colors[index],
                      width: 22,
                      borderRadius: BorderRadius.circular(6),
                      rodStackItems: [],
                    ),
                  ],
                  showingTooltipIndicators: [0],
                );
              }),
              barTouchData: BarTouchData(enabled: false),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Optional: Add alert icon above "Kosher"
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(values.length, (index) {
              if (labels[index] == 'Kosher') {
                return SizedBox(
                  width: 60,
                  child: Center(
                    child: Icon(Icons.warning_rounded, color: Colors.red, size: 20),
                  ),
                );
              } else {
                return const SizedBox(width: 60);
              }
            }),
          ),
        ),
      ],
    );
  }
}
