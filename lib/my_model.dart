import 'package:cuancerdas/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  Widget display = DashboardPage();

  void changeDisplay(Widget page) {
    display = page;
    notifyListeners();
  }
}
