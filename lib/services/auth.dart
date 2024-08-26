import 'package:cuancerdas/services/failure.dart';
import 'package:cuancerdas/pages/homepage.dart';
import 'package:cuancerdas/signin/signin_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// final user = FirebaseAuth.instance.currentUser;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  static late final Rx<User?> firebaseUser;

  User? get user => _auth.currentUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignInPage())
        : Get.offAll(() => const HomePage());
  }

  void createUserWithEmailAndPass(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      debugPrint("Done created User!");
      // await DatabaseService(uid: user!.uid).updateGeneral(0);
      firebaseUser.value == null
          ? Get.to(() => const SignInPage())
          : Get.offAll(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPassFailure.code(e.code);
      debugPrint("The firebase error is ${ex.message}");
    } catch (_) {
      final ex = SignUpWithEmailAndPassFailure();
      debugPrint("The error is ${ex.message}");
    }
  }

  Future<void> loginWithEmailAndPass(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.stackTrace);
    } catch (_) {}
  }

  void handleGoogleLogin() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCred = await _auth.signInWithProvider(_googleAuthProvider);
      final User? user = userCred.user;
      if (user != null) {
      // Check if user exists in Firestore
      // DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      // if (!userDoc.exists) {
      //   // User does not exist, meaning this is their first login
      //   await DatabaseService(uid: user.uid).updateGeneral(0);
      // }
    }

    } catch (err) {
      print(err);
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
