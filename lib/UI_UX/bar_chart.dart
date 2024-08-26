import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatefulWidget {
  MyBarChart({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<MyBarChart> {
  final Map<String, double> incomeData = {
    'Rent': 1200.0,
    'Groceries': 300.0,
    'Salary': 5000.0,
  };

  final Map<String, double> expenseData = {
    'Rent': 1200.0,
    'Groceries': 300.0,
    'Utilities': 150.0,
  };

  @override
  Widget build(BuildContext context) {
    final sortedItems = [
      ...incomeData.keys,
      ...expenseData.keys,
    ].toSet().toList()
      ..sort();

    final barGroups = sortedItems.map((item) {
      final income = incomeData[item] ?? 0;
      final expense = expenseData[item] ?? 0;

      return BarChartGroupData(
        x: sortedItems.indexOf(item),
        barRods: [
          BarChartRodData(
            toY: income,
            color: Colors.green,
            width: 15,
            borderRadius: BorderRadius.zero,
          ),
          BarChartRodData(
            toY: expense,
            color: Colors.red,
            width: 15,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                // tooltipBgColor: Colors.transparent,
                ),
            // touchCallback: (barTouchResponse) {},
            handleBuiltInTouches: true,
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 30,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  final itemName = sortedItems[index];
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      itemName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      '${value.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color(0xff37434d),
              width: 1,
            ),
          ),
          gridData: FlGridData(show: false),
          groupsSpace: 4,
          // barsSpace: 4,
          barGroups: barGroups,
        ),
      ),
    );
  }
}

BarChartGroupData makeGroupData(
  int x,
  double y,
) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: x >= 4 ? Colors.transparent : Colors.amber,
        borderRadius: BorderRadius.zero,
        borderDashArray: x >= 4 ? [4, 4] : null,
        width: 22,
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
    ],
  );
}

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  Widget text = Text(
    days[value.toInt()],
    style: style,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: text,
  );
}

BarChartData randomData() {
  return BarChartData(
    maxY: 300.0,
    barTouchData: BarTouchData(
      enabled: false,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getTitles,
          reservedSize: 38,
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: List.generate(
      7,
      (i) => makeGroupData(
        i,
        Random().nextInt(290).toDouble() + 10,
      ),
    ),
    gridData: const FlGridData(show: false),
  );
}
