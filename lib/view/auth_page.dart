import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/view/homepage.dart';
import 'package:mechinetestforinfonix/view/mobileauth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/5847f40ecef1014c0b5e488a.png",
            width: maxWidth / 3,
          ),
          GetBuilder<Controller>(
            builder: (controller) {
              return FloatingActionButton.extended(
                heroTag: "btn1",
                backgroundColor: Colors.blue[400],
                icon: Image.asset(
                  "assets/images/google-logo-9824.png",
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  controller.loginWithGmail();
                  controller.userIsAlreadyLogin==true?Get.off(()=>HomePage()):print("try again");
                },
                label: const Text(
                  "Sign With Google",
                ),
              );
            },
          ),
          GetBuilder<Controller>(
            builder: (controller) {
              return FloatingActionButton.extended(
                heroTag: "btn2",
                backgroundColor: Colors.green[400],
                icon: Image.asset(
                  "assets/images/icons8-phone-48.png",
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  Get.to(() => MobileAuth());
                },
                label: const Text(
                  "Sign With Phone",
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
