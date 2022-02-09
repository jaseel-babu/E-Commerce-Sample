import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/apiservice.dart';
import 'package:mechinetestforinfonix/controller/cartcontroller.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';
import 'package:mechinetestforinfonix/view/auth_page.dart';
import 'package:mechinetestforinfonix/view/cartpage.dart';
import 'package:mechinetestforinfonix/view/drawer.dart';
import 'package:mechinetestforinfonix/view/items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  ApiService apiService = ApiService();
  var controller = Get.put(Controller());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataModel?>(
        future: apiService.getDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DataModel? dataModel = snapshot.data;
            return DefaultTabController(
              length: 6,
              child: Scaffold(
                key: scaffoldKey,
                drawer: Menu(),
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      if (scaffoldKey.currentState!.isDrawerOpen) {
                        scaffoldKey.currentState!.openEndDrawer();
                      } else {
                        scaffoldKey.currentState!.openDrawer();
                      }
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    GetBuilder<CartControll>(
                        id: "valuechanged",
                        builder: (controller) {
                          return InkWell(
                            onTap: () => Get.to(() => CartPage()),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                      controller.MyItems.length.toString()),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: [
                      ...dataModel!.tableMenuList!.map(
                        (e) => Tab(
                          text: e.menuCategory,
                        ),
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Items(currentIndex: 0, dataModel: dataModel),
                    Items(currentIndex: 1, dataModel: dataModel),
                    Items(currentIndex: 2, dataModel: dataModel),
                    Items(currentIndex: 3, dataModel: dataModel),
                    Items(currentIndex: 4, dataModel: dataModel),
                    Items(currentIndex: 5, dataModel: dataModel)
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
