import 'package:cuancerdas/services/auth.dart';
import 'package:cuancerdas/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(String email, String password){
    Get.offAll(() => const HomePage());
    AuthenticationRepository.instance.createUserWithEmailAndPass(email, password);
  }
}