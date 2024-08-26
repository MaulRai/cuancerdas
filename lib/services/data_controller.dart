// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DataController extends GetxController {
//   Random random = Random();
//   int cnt = 0;

//   List<String> expenseCategories = [
//     'Rent',
//     'Groceries',
//     'Utilities',
//     'Transport',
//     'DiningOut',
//     'Healthcare',
//     'Insurance',
//     'Education',
//     'Entertainment',
//     'Travel',
//     'Clothing',
//     'Gifts',
//     'Savings',
//     'Investments',
//     'Subscriptions',
//     'Pets',
//     'Hobbies',
//     'ChildCare',
//     'Fitness',
//     'Misc'
//   ];
//   var _coin = 0.obs;
//   var _expensesList = [
//     PieChartSectionData(
//         value: 1000,
//         title: "Income",
//         showTitle: true,
//         titleStyle: TextStyle(color: Colors.white),
//         radius: 70,
//         color: Colors.green),
//     PieChartSectionData(
//         value: 1200,
//         title: "Expenses",
//         titleStyle: TextStyle(color: Colors.white),
//         showTitle: true,
//         radius: 70,
//         color: Colors.pink),
//     ].obs;
//   int get coin => _coin.value;
//   List<PieChartSectionData> get expensesList => _expensesList.cast<PieChartSectionData>();

//   void setCoin(int newCoin) {
//     _coin = (_coin.value + newCoin).obs;
//     update();
//   }

//   void addExp() {
//     _expensesList.add(PieChartSectionData(
//       value: 3000,
//       title: expenseCategories[cnt],
//       showTitle: true,
//       radius: 70,
//       color: Color(getRandomPastelColor()),
//     ));
//     cnt++;
//     update();
//   }

//   int getRandomPastelColor() {
//     final Random random = Random();

//     // Generate a random RGB color
//     int red = random.nextInt(256);
//     int green = random.nextInt(256);
//     int blue = random.nextInt(256);

//     // Mix the color with white to get a pastel color
//     red = ((red + 255) / 2).toInt();
//     green = ((green + 255) / 2).toInt();
//     blue = ((blue + 255) / 2).toInt();

//     // Combine into an ARGB integer value
//     return (255 << 24) | (red << 16) | (green << 8) | blue;
//   }
// }
