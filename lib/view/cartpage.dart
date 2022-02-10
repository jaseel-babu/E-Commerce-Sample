// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/cartcontroller.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/view/counter.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  var controller = Get.put(CartControll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Order Summary'),
      ),
      body: SafeArea(
        child: Card(
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.green[900],
                title: const Center(
                  child: Text(
                    "2 Dishes - 2 Items",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GetBuilder<CartControll>(
                builder: (controller) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.MyItems.length,
                    itemBuilder: (context, index) {
                      controller.totalforOneItem = controller.MyItems[index]
                              ["count"] *
                          controller.MyItems[index]["dishprice"];
                      return Card(
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    controller.MyItems[index]["dishname"]
                                        .toString(),
                                  ),
                                ),
                                Text(controller.MyItems[index]["dishprice"]
                                    .toString()),
                              ],
                            ),
                            GetBuilder<CartControll>(
                              id: "update",
                              builder: (controller) {
                                return CountButtonView(
                                  increment: () {
                                    int? counter = controller.MyItems[index]
                                        ["count"] as int;
                                    controller.MyItems[index]["count"] =
                                        counter + 1;
                                    controller.count =
                                        controller.MyItems[index]["count"];
                                    controller.totalforOneItem = controller
                                            .count! *
                                        controller.MyItems[index]["dishprice"];
                                    controller.MyItems[index]["priceforTotal"] =
                                        controller.totalforOneItem;
             
                                      controller.total = controller.total! +
                                          controller.MyItems[index]
                                              ["dishprice"];
                                    
                                    controller.update(
                                      ["update"],
                                    );

                                    controller.update(["valuechanged"]);
                                  },
                                  currentIndex: index,
                                  count: controller.MyItems[index]["count"]
                                      .toString(),
                                  decrement: () {
                                    int? counter =
                                        controller.MyItems[index]["count"];
                                    if (counter! > 0) {
                                      int count = controller.MyItems[index]
                                          ["count"] = counter - 1;
                                      controller.count =
                                        controller.MyItems[index]["count"];
                                    controller.totalforOneItem = controller
                                            .count! *
                                        controller.MyItems[index]["dishprice"];
                                    controller.MyItems[index]["priceforTotal"] =
                                        controller.totalforOneItem;
             
                                      controller.total = controller.total! -
                                          controller.MyItems[index]
                                              ["dishprice"];

                                      controller.update(["update"]);
                                       controller.update(["valuechanged"]);
                                    }
                                  },
                                  initialCount: 0,
                                );
                              },
                            ),
                            GetBuilder<CartControll>(
                              id: "update",
                              builder: (controller) {
                                return Text(
                                    controller.MyItems[index]["priceforTotal"] .toString());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              GetBuilder<CartControll>(
                id: "update",
                builder: (controller) {
                  return ListTile(
                    tileColor: Colors.green[900],
                    title: Center(
                      child: Text(
                        "Total Price${controller.total!}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
