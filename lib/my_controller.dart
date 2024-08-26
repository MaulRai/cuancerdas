import 'package:cuancerdas/pages/prod_cat_page.dart';
import 'package:cuancerdas/pages/profile_page.dart';
import 'package:cuancerdas/pages/in_ex_page.dart';
import 'package:cuancerdas/pages/chat_page.dart';
import 'package:cuancerdas/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  final List<Widget> pages = [
    ProfilePage(),
    ChatPage(),
    InExPage(),
    CategoryPage(),
    DashboardPage()
  ];
  Rx<Widget> display = (DashboardPage() as Widget).obs;

  void setDisplay(int index){
    display.value = (pages[index]) as Widget;
  }
}
