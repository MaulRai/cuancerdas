import 'dart:convert';

import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return currencyFormatter.format(amount);
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('y/M/d');
  return formatter.format(date);
}

class Income {
  int no;
  String name;
  int amount;
  String item;
  DateTime date;
  static double totalIncome = 0;
  static Map<String, double> history = {};
  static Map<String, double> totalPerItem = {};

  Income(this.no, this.name, this.amount, this.item, this.date) {
    if (history.containsKey(fDate)) {
      history[fDate] = history[fDate]! + totalPrice;
    } else {
      history[fDate] = totalPrice;
    }
    if (totalPerItem.containsKey(item)) {
      totalPerItem[item] = totalPerItem[item]! + amount;
    } else {
      totalPerItem[item] = amount.toDouble();
    }
    totalIncome += totalPrice;
  }

  double get discount => (Product.getDiscount(item) / 100 * totalPrice);
  double get price => Product.getPrice(item);
  double get totalPrice => (){print('harganya: ${Product.getPrice(item)}');return Product.getPrice(item) * amount;}();
  String get fPrice => formatCurrency(Product.getPrice(item));
  String get fDate => formatDate(date);

  static String jsonStringify() {
    final Map<String, dynamic> data = {
      'totalIncome': totalIncome,
      'history': history,
      'totalPerItem': totalPerItem,
    };
    return jsonEncode(data);
  }
}

class Product {
  String item;
  double price;
  double discount;
  static Map<String, double> itemDiscount = {};
  static Map<String, double> priceMap = {};

  Product(this.item, this.price, this.discount) {
    itemDiscount[item] = discount;
    if (!priceMap.containsKey(item)) {
      priceMap[item] = price;
      print(priceMap.toString());
    }
  }

  static double getPrice(String theItem) {
    // print('isi map: ${priceMap.toString()}');
    return priceMap[theItem]!;
  }

  static double getDiscount(String theItem) => itemDiscount[theItem]!;

  String get fPrice => formatCurrency(price);
  String get stringDisc => discount.toString();

  static String jsonStringify() {
    final Map<String, dynamic> data = {
      'itemDiscount': itemDiscount,
      'priceMap': priceMap,
    };
    return jsonEncode(data);
  }
}

class Expense {
  String desc;
  double price;
  String category;
  DateTime date = DateTime.now();
  static double totalExpenses = 0;
  static Map<String, double> totalPerItem = {};
  static Map<String, double> history = {};

  Expense(this.desc, this.price, this.category) {
    if (totalPerItem.containsKey(category)) {
      totalPerItem[category] = totalPerItem[category]! + price;
    } else {
      totalPerItem[category] = price;
    }
    if (history.containsKey(fDate)) {
      history[fDate] = history[fDate]! + price;
    } else {
      history[fDate] = price;
    }
    totalExpenses += price;
  }
  
  Expense.custom(this.desc, this.price, this.category, this.date) {
    if (totalPerItem.containsKey(category)) {
      totalPerItem[category] = totalPerItem[category]! + price;
    } else {
      totalPerItem[category] = price;
    }
    if (history.containsKey(fDate)) {
      history[fDate] = history[fDate]! + price;
    } else {
      history[fDate] = price;
    }
    totalExpenses += price;
  }

  String get fDate => formatDate(date);
  String get fPrice => formatCurrency(price);

  static String jsonStringify() {
    final Map<String, dynamic> data = {
      'totalExpenses': totalExpenses,
      'history': history,
      'totalPerItem': totalPerItem,
    };
    return jsonEncode(data);
  }
}

class Category {
  String name;
  String desc;

  Category(this.name, this.desc);
}
