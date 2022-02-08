import 'package:get/get.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';

class CounterController extends GetxController {
  DataModel dataModel = DataModel();

  void updateCount(int addValue, Function(int) onChange, int currentIndex,int catagoriy) {
    if (dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount==null) {
      dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount =  dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount! +0;
    }
    if (dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount!+ addValue >= 0) {
      dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount =  dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount! +addValue;
      //update(["update"]);
      if (onChange != null) {
        onChange(dataModel.tableMenuList![catagoriy].categoryDishes![currentIndex].cartcount!);
      }
    }
  }
}
