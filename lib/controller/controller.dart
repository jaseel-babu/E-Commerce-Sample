import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  GoogleSignInAccount? googleaccount;
  bool? googlesignedornot ;
  bool? userIsAlreadyLogin;
  String verificationId = "";
  @override
  void onInit() {
    //checkLoginOrNot();
    super.onInit();
  }

  var _googleSignin = GoogleSignIn();
  loginWithGmail() async {
    try {
      this.googleaccount = await _googleSignin.signIn();
      final googleAuth = await googleaccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      print(googleaccount!.displayName);
      await FirebaseAuth.instance.signInWithCredential(credential);
    
      SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool("login",true);
     userIsAlreadyLogin = prefs.getBool("login");

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
