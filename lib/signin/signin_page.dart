import 'package:cuancerdas/services/auth.dart';
import 'package:cuancerdas/services/signup_controller.dart';
import 'package:cuancerdas/pages/homepage.dart';
import 'package:cuancerdas/signup/signup_page.dart';
import 'package:cuancerdas/UI_UX/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String err = "";
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: SafeArea(child: Text("Log in"))),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              thirdPartyLogin(),
              Text("Or use your email account to login"),
              appTextField(
                text: "Email",
                hintText: "Enter your email address",
                controller: controller.email,
              ),
              appTextField(
                  text: "Password",
                  icon: Icon(Icons.lock),
                  hintText: "Enter password",
                  obscureText: true,
                  controller: controller.password),
              warningText(err),
              Container(child: textUnderLine("Forgot password?")),
              SizedBox(height: 100),
              appButton("Login", context, true, loginHandle: _loginhandle),
              appButton("Sign up", context, false),
            ],
          ),
        ));
  }

  void _loginhandle() async {
    String errorMessage = "";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controller.email.text.trim(),
          password: controller.password.text.trim());
      Get.offAll(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorMessage = ('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        errorMessage =
            ('Either your account isn\'t registered or worng password');
      }
      print("INI PESANNYA FIREBASE ++++++ ${e.code}");
    } catch (e) {
      print("INI PESANNYA ++++++ $e");
    }
    setState(() {
      err = errorMessage;
    });
  }
}

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 80),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _googleLoginButton(),
        _loginButton("resources/apple_icon.png"),
        _loginButton("resources/dc_icon.png"),
      ],
    ),
  );
}

Widget _googleLoginButton() {
  return GestureDetector(
    onTap: AuthenticationRepository.instance.handleGoogleLogin,
    child: Container(
      width: 40,
      height: 40,
      child: Image.asset("resources/google_icon.png"),
    ),
  );
  
  // return GestureDetector(
  //   onTap: (){

  //   },
  //   child: Container(
  //     width: 40,
  //     height: 40,
  //     child: Image.asset("resources/google_icon.png"),
  //   ),
  // );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    child: Container(
      width: 40,
      height: 40,
      child: Image.asset(imagePath),
    ),
  );
}

Widget appButton(String text, BuildContext context, bool isLogin,
    {Function? loginHandle}) {
  return GestureDetector(
    onTap: () {
      (isLogin) ? loginHandle!() : Get.to(SignUpPage());
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 15),
      width: 325,
      height: 50,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
