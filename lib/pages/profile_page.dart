import 'package:cuancerdas/UI_UX/widget.dart';
import 'package:cuancerdas/signin/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200),
          _profileInfo(),
          _logOutButton(),
        ],
      ),
    );
  }

  Widget _logOutButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: aButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Get.offAll(() => const SignInPage());
          },
          child: simpleText("Log Out"),
        ),
      ),
    );
  }

  Widget _profileInfo() {
    final _user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(40), // Image radius
                    child: _user == null || _user.photoURL == null
                        ? Image.asset("resources/karr.jpg")
                        : Image.network(_user.photoURL!),
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
            Container(
              width: 85,
              height: 85,
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.blue[100],
                radius: 15,
                child: Icon(
                  Icons.edit_square,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        simpleText(_user!.displayName ?? ""),
        simpleText(_user.email ?? "")
      ],
    );
  }
}
