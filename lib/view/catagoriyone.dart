import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/countercontroller.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';
import 'package:mechinetestforinfonix/view/counter.dart';

class CategoriOne extends StatelessWidget {
  final controller = Get.put(CounterController());
  CategoriOne({Key? key, required this.currentIndex, required this.dataModel})
      : super(key: key);
  int currentIndex;
  DataModel dataModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount:
              dataModel.tableMenuList![currentIndex].categoryDishes!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                dataModel.tableMenuList![currentIndex].categoryDishes![index]
                    .dishName!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    dataModel.tableMenuList![currentIndex]
                        .categoryDishes![index].dishDescription!,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<CounterController>(
                      id: "update",
                      builder: (controller) {
                        return CountButtonView(
                          increment: () {
                            controller.updateCount(1, (count) {}, index,currentIndex);
                          
                          },
                          currentIndex: index,
                          count:  "${ dataModel.tableMenuList![currentIndex].categoryDishes![index].cartcount }",
                          decrement: () {
                            controller.updateCount(-1, (count) {}, index,currentIndex);
                            
                          },
                          initialCount: 0,
                          // onChange: (count) {},
                        );
                      })
                ],
              ),
              trailing: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    onError: (exception, stackTrace) => stackTrace,
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      dataModel.tableMenuList![currentIndex]
                          .categoryDishes![index].dishImage!,
                      errorListener: () => FlutterLogo(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
