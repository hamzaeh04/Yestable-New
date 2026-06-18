import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';

class CommonAllergensChart extends StatelessWidget {
  final List<Map<String, dynamic>> allergensList;
  final List<String>? yAxisLabels;
  final bool isGrouped;
  const CommonAllergensChart({
    super.key,
    required this.allergensList,
    this.yAxisLabels,
    this.isGrouped = false,
  });

  // Data for the bar chart
  static const List<Map<String, dynamic>> _chartData = [
    {"label": "Tree Nuts", "value": 3, "color": Color(0xFF7E00F5), "valueText": "03"},
    {"label": "Peanuts", "value": 6, "color": Color(0xFFFF5B00), "valueText": "06"},
    {"label": "Sesame", "value": 2, "color": Color(0xFF8A959E), "valueText": "02"},
    {"label": "Dairy", "value": 8, "color": Color(0xFFE1C500), "valueText": "08", "showAlert": true},
    {"label": "Gluten", "value": 5, "color": Color(0xFF39D300), "valueText": "05"},
    {"label": "Shellfish", "value": 3, "color": Color(0xFFE19B00), "valueText": "03"},
    {"label": "Eggs", "value": 4, "color": Color(0xFF00B58D), "valueText": "04"},
  ];

  @override
  Widget build(BuildContext context) {
    const double chartHeight = 130.0;
    final double yAxisWidth = (yAxisLabels != null) ? 55.0 : 35.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grid + Bars Container
        SizedBox(
          height: chartHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: Y-Axis Labels (10, 05, 00 or custom labels)
              SizedBox(
                width: yAxisWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      text: (yAxisLabels != null && yAxisLabels!.isNotEmpty) ? yAxisLabels![0] : "10",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    customText(
                      text: (yAxisLabels != null && yAxisLabels!.length > 1) ? yAxisLabels![1] : "05",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    customText(
                      text: (yAxisLabels != null && yAxisLabels!.length > 2) ? yAxisLabels![2] : "00",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              // Right: fl_chart BarChart with custom overlays for value text and siren alert
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // fl_chart BarChart (renders bars and grid lines)
                    BarChart(
                      BarChartData(
                        maxY: 10,
                        minY: 0,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.shade200,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(
                          show: false, // hidden so overlays align perfectly
                        ),
                        barGroups: List.generate(allergensList.length, (index) {
                          final data = allergensList[index];
                          
                          if (isGrouped) {
                            final List<Map<String, dynamic>> rodsData = List<Map<String, dynamic>>.from(data["rods"] ?? []);
                            return BarChartGroupData(
                              x: index,
                              barRods: rodsData.map((rod) {
                                final double value = (rod["value"] as num).toDouble();
                                final Color color = rod["color"] as Color;
                                return BarChartRodData(
                                  toY: value,
                                  color: color,
                                  width: 2.w,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                );
                              }).toList(),
                              barsSpace: 0.5.w,
                            );
                          }

                          final double value = (data["value"] as num).toDouble();
                          final Color color = data["color"] as Color;

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: value,
                                color: color,
                                width: 8.w,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                              ),
                            ],
                          );
                        }),
                        alignment: BarChartAlignment.spaceAround,
                      ),
                    ),

                    // Custom Overlay for annotations (value text and siren emoji)
                    Positioned.fill(
                      child: Row(
                        children: allergensList.map((data) {
                          if (isGrouped) {
                            final List<Map<String, dynamic>> rodsData = List<Map<String, dynamic>>.from(data["rods"] ?? []);
                            return Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: chartHeight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(rodsData.length, (rodIndex) {
                                      final rod = rodsData[rodIndex];
                                      final double value = (rod["value"] as num).toDouble();
                                      final String valueText = rod["valueText"] as String;
                                      final bool showAlert = rod["showAlert"] as bool? ?? false;
                                      final double barHeight = (value / 10.0) * chartHeight;

                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 2.w,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                if (value > 1.2)
                                                  Positioned(
                                                    bottom: 0.4.h,
                                                    child: customText(
                                                      text: valueText,
                                                      fontSize: 8.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                if (showAlert)
                                                  Positioned(
                                                    bottom: barHeight + 0.4.h,
                                                    child: customText(
                                                      text: "🚨",
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          if (rodIndex < rodsData.length - 1)
                                            SizedBox(width: 0.5.w),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            );
                          }

                          final double value = (data["value"] as num).toDouble();
                          final String valueText = data["valueText"] as String;
                          final bool showAlert = data["showAlert"] as bool? ?? false;
                          final double barHeight = (value / 10.0) * chartHeight;

                          return Expanded(
                            child: Center(
                              child: SizedBox(
                                height: chartHeight,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // Value Text inside the bar near the bottom
                                    Positioned(
                                      bottom: 0.6.h,
                                      child: customText(
                                        text: valueText,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                    ),
                                    // Siren Emoji above the bar
                                    if (showAlert)
                                      Positioned(
                                        bottom: barHeight + 0.4.h,
                                        child: customText(
                                          text: "🚨",
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),

        // X-Axis Labels below the chart
        Row(
          children: [
            SizedBox(width: yAxisWidth),
            Expanded(
              child: Row(
                children: allergensList.map((data) {
                  final String label = data["label"] as String;
                  return Expanded(
                    child: Center(
                      child: customText(
                        text: label,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
