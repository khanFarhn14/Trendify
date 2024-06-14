import 'package:get/get.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/services/api_url.dart';
import 'package:trendify/services/network_services/base_api_service.dart';
import 'package:trendify/services/network_services/network_api_service.dart';
import 'package:trendify/state_management/reactive_products_list.dart';
import 'package:trendify/state_management/reactive_user_cart.dart';

class ProductsRepository{
  final BaseApiServices _apiServices = NetworkApiService();
  final ReactiveProductList reactiveProductList = Get.put(ReactiveProductList());
    final ReactiveUserCart reactiveUserCart = Get.put(ReactiveUserCart());

  Future<void> getAllProducts() async{
    try{
      reactiveProductList.isProductFetched.value = false;
      reactiveProductList.productList.clear();

      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.allProductsUrl);
      dynamic cartItemResponse = await _apiServices.getAPIResponse(ProductsUrl.cartItemsUrl);

      int length = cartItemResponse[0]['products'].length;

      reactiveUserCart.userCart.value = cartItemResponse[0]['products'];


      reactiveUserCart.numberOfCartItems.value = length;

      reactiveProductList.productList.value = response;
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = true;

    }catch(e){
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = false;
    }
  }

  Future<void> sortProducts() async{
    try{
      reactiveProductList.isProductFetched.value = false;
      reactiveProductList.productList.clear();
      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.sortDescProductUrl);
      clearPrint(response.runtimeType.toString());

      reactiveProductList.productList.value = response;
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = true;
    }catch(e){
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = false;
    }
  }

  Future<bool> getCategory() async{
    try{
      reactiveProductList.categories.clear();
      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.allCateogriesUrl);
      reactiveProductList.categories.value = response;

      return true;
    }catch(e){
      return false;
    }
  }

  Future<void> getSpecificCategory(String category) async{
    try{
      reactiveProductList.isProductFetched.value = false;
      reactiveProductList.productList.clear();
      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.productSpecificCategoryUrl+category);
      reactiveProductList.productList.value = response;
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = true;
    }catch(e){
      reactiveProductList.isProductFetched.value = true;
      reactiveProductList.isResponseHadData.value = false;
    }
  }
}