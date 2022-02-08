import 'package:get/get.dart';

class CounterController extends GetxController {
  
  int count=0 ;
  void updateCount(int addValue, Function(int) onChange,int currentIndex) {
    if (count + addValue >= 0) {
      count += addValue;
     //update(["update"]);
      if (onChange != null) {
       onChange(count);
      }
    }
  }
}
