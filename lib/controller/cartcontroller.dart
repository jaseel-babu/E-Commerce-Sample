import 'package:get/get.dart';
import 'package:mechinetestforinfonix/model/datamodel.dart';

class CartControll extends GetxController {
  DataModel dataModel = DataModel();
  List MyItems = [];
  List priceOfOneItem = [];
  int? count;
  num? totalforOneItem;
  num? total = 0;
}
