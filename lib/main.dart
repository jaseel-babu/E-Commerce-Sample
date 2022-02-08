import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/view/auth_page.dart';
import 'package:mechinetestforinfonix/view/homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(Controller());
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(Controller());
  @override
  void initState() {
    controller.checkLoginOrNot();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return GetBuilder<Controller>( 
      builder: (controller) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: controller.userIsAlreadyLogin == true ? HomePage() : LoginPage());
      }
    );
  }
}
