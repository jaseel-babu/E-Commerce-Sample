import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechinetestforinfonix/controller/cartcontroller.dart';

typedef void CountButtonClickCallBack(int );

class CountButtonView extends StatelessWidget {
  
  Function increment;
  Function decrement;
  final int initialCount;
  final int currentIndex;
  String count;

  CountButtonView({
    required this.count,
    required this.increment,
    required this.initialCount,
    required this.currentIndex,
    required this.decrement,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.0,
      height: 44.0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(22.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  decrement();
                  
                },
                child: const SizedBox(
                  width: 40.0,
                  child: Center(
                    child: Text(
                      '-',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Center(
                    child: Text(
                  count,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                )),
              ),
              GestureDetector(
                onTap: () {
                  increment();
                 
                },
                child: const SizedBox(
                  width: 40.0,
                  child: Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
