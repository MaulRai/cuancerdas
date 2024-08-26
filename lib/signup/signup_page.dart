import 'package:cuancerdas/services/signup_controller.dart';
import 'package:cuancerdas/UI_UX/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final controller = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appTextField(
                      text: "Email",
                      hintText: "Enter your email address",
                      controller: controller.email),
                  appTextField(
                      text: "Full Name",
                      hintText: "Enter your full name",
                      controller: controller.fullName),
                  appTextField(
                      text: "Phone Number",
                      hintText: "Enter your phone number",
                      controller: controller.phoneNo),
                  appTextField(
                      text: "Password",
                      icon: Icon(Icons.lock),
                      hintText: "Enter password",
                      obscureText: true,
                      controller: controller.password),
                  appTextField(
                      text: "Re-enter password",
                      icon: Icon(Icons.lock),
                      hintText: "Enter password",
                      obscureText: true),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SignUpController.instance.registerUser(
                            controller.email.text.trim(),
                            controller.password.text.trim());
                      }
                    },
                    child: Text("Sign up"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CardModel>(
//       builder: (context, value, child) {
//         return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//               title: Text("EcoEarn"),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Bubble chat!',
//                   ),
//                   ...value.bubbles
//                 ],
//               ),
//             ),
//             floatingActionButton: FloatingActionButton(
//               child: Icon(Icons.add),
//               onPressed: (){
//                 final theList = context.read<CardModel>();
//                 theList.handleButton();
//               },
//             ));
//       }
//     );
//   }
// }