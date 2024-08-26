import 'package:cuancerdas/UI_UX/navigation.dart';
import 'package:cuancerdas/my_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final String userId = FirebaseAuth.instance.currentUser!.uid;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(MyController());
    bool _atBottom = false;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 24, 37),
      resizeToAvoidBottomInset: false, // Prevents resize when keyboard appears
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GetX<MyController>(builder: (context) {
                  return controller.display.value;
                }),
                // value.display,

                /// Fader Effect
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: height - 130,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 16, top: 30, bottom: 8),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset('resources/cuancerdas.png'),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AppFaderEffect(atBottom: _atBottom),
                ),
              ],
            ),
          ),

          /// Bottom Navigation Bar
          AppBBN(
            atBottom: _atBottom,
          ),
        ],
      ),
    );
  }
}
