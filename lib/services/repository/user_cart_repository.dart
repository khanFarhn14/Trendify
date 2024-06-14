import 'package:get/get.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/services/api_url.dart';
import 'package:trendify/services/network_services/base_api_service.dart';
import 'package:trendify/services/network_services/network_api_service.dart';
import 'package:trendify/state_management/reactive_user_cart.dart';

class UserCartRepository{
  final BaseApiServices _apiServices = NetworkApiService();
    final ReactiveUserCart _reactiveUserCart = Get.put(ReactiveUserCart());

    Future<void> getUserCartItem() async{
      _reactiveUserCart.isUserCartFetched.value = false;
      _reactiveUserCart.isUserCartHasData.value = false;
      
      try{
        _reactiveUserCart.userCartDetailedList.clear();
        int length = _reactiveUserCart.userCart.length;
        for(int i = 0; i < length; i++){
          String productId = _reactiveUserCart.userCart[i]['productId'].toString();
          final response = await _apiServices.getAPIResponse(ProductsUrl.specificProductsUrl+productId);
          _reactiveUserCart.userCartDetailedList.add(response);
        }

        _reactiveUserCart.isUserCartFetched.value = true;
        _reactiveUserCart.isUserCartHasData.value = true;

        clearPrint(_reactiveUserCart.userCartDetailedList.length.toString());

      }catch(e){
        clearPrint(e.toString());
        _reactiveUserCart.isUserCartFetched.value = true;
        _reactiveUserCart.isUserCartHasData.value = false;
      }
    }
}