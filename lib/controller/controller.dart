import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mechinetestforinfonix/view/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  GoogleSignInAccount? googleaccount;
  bool? googlesignedornot;
  bool? userIsAlreadyLogin;
  String verificationId = "";
  @override
  void onInit() {
    //checkLoginOrNot();
    super.onInit();
  }

  final _googleSignin = GoogleSignIn();
  loginWithGmail() async {
    try {
      googleaccount = await _googleSignin.signIn();
      final googleAuth = await googleaccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      print(googleaccount!.displayName);
      await FirebaseAuth.instance.signInWithCredential(credential);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("login", true);
      userIsAlreadyLogin = prefs.getBool("login");
      Get.off(() => HomePage());
    } on SocketException {
      Fluttertoast.showToast(msg: "No internet connection");
    } on PlatformException {
      Fluttertoast.showToast(msg: "Invalid Format");
    } catch (e) {
      print(e);
    }
  }

  checkLoginOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userIsAlreadyLogin = prefs.getBool("login");
    print(userIsAlreadyLogin);

    update();
  }

  logoutWithGmail() async {
    this.googleaccount = await _googleSignin.signOut();
    googlesignedornot = false;
    update();
  }
}
