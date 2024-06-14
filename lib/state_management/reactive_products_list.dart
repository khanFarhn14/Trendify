import 'package:get/get.dart';

class ReactiveProductList extends GetxController{
  RxBool isProductFetched = false.obs;
  RxBool isResponseHadData = true.obs;

  RxList<dynamic> productList = [].obs;
  RxList<dynamic> categories = [].obs;

  // RxList<dynamic> userCart = [].obs;
  // RxInt numberOfCartItems = 0.obs;

}