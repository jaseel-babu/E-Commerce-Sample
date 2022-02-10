import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/view/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  var controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: GetBuilder<Controller>(
                builder: (controller) {
                  return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Sorry Something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final user = snapshot.data as User;
                      return Column(
                        children: [
                          CircleAvatar(
                            child:const Icon(Icons.person),
                            backgroundImage: user.photoURL == null
                                ? null
                                : NetworkImage(user.photoURL!),
                          ),
                          user.displayName == null
                              ? Text(user.phoneNumber!)
                              : Text(user.displayName!)
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () async {
                controller.logoutWithGmail();
                Get.to(() => LoginPage());
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("login", false);
              },
            )
          ],
        ),
      ),
    );
  }
}
