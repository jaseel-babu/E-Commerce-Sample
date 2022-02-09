import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/cartcontroller.dart';
import 'package:mechinetestforinfonix/controller/controller.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';
import 'package:mechinetestforinfonix/view/counter.dart';

class Items extends StatelessWidget {
  final controller = Get.put(CartControll());
  Items({Key? key, required this.currentIndex, required this.dataModel})
      : super(key: key);
  final int currentIndex;
  int count = 0;
  final DataModel dataModel;
  final product = CategoryDish();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataModel.tableMenuList![currentIndex].categoryDishes!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
            width: 100,
            child: Text(
              dataModel.tableMenuList![currentIndex].categoryDishes![index]
                  .dishName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "INR ${dataModel.tableMenuList![currentIndex].categoryDishes![index].dishPrice.toString()}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    " ${dataModel.tableMenuList![currentIndex].categoryDishes![index].dishCalories.toString()} calories",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dataModel.tableMenuList![currentIndex].categoryDishes![index]
                    .dishDescription!,
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<CartControll>(
                  id: "update",
                  builder: (controller) {
                    return CountButtonView(
                      increment: () {
                        int? counter = dataModel.tableMenuList![currentIndex]
                            .categoryDishes![index].cartcount;
                        int count = dataModel.tableMenuList![currentIndex]
                            .categoryDishes![index].cartcount = counter! + 1;
                        final map = {
                          "count": count,
                          "dishname": dataModel.tableMenuList![currentIndex]
                              .categoryDishes![index].dishName!,
                          "dishprice": dataModel.tableMenuList![currentIndex]
                              .categoryDishes![index].dishPrice!,
                          "index": index,
                        };
                        controller.MyItems.add(map);
                          controller.total = controller.total! +
                                         dataModel.tableMenuList![currentIndex]
                              .categoryDishes![index].dishPrice!;
                        controller.update(["update"]);

                        controller.update(["valuechanged"]);
                      },
                      currentIndex: index,
                      count:
                          "${dataModel.tableMenuList![currentIndex].categoryDishes![index].cartcount}",
                      decrement: () {
                        int? counter = dataModel.tableMenuList![currentIndex]
                            .categoryDishes![index].cartcount;
                        if (counter! > 0) {
                          dataModel.tableMenuList![currentIndex]
                              .categoryDishes![index].cartcount = counter - 1;
                          controller.update(["update"]);
                        }
                      },
                      initialCount: 0,
                    );
                  })
            ],
          ),
          // trailing: Container(
          //   width: 100,
          //   height: 100,
          //   child: Image.network(
          //     dataModel.tableMenuList![currentIndex].categoryDishes![index]
          //         .dishImage!,
          //     errorBuilder: (context, error, stackTrace) => const FlutterLogo(),
          //   ),
          // ),
        );
      },
    );
  }
}
