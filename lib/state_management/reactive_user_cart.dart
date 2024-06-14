import 'package:get/get.dart';

class ReactiveUserCart extends GetxController{
  RxBool isUserCartFetched = false.obs;
  RxBool isUserCartHasData = true.obs;

  RxList<dynamic> userCartDetailedList = [].obs;
  // RxList<dynamic> categories = [].obs;

  RxList<dynamic> userCart = [].obs;
  RxInt numberOfCartItems = 0.obs;

}