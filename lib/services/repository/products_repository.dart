import 'package:trendify/resources.dart';
import 'package:trendify/services/api_url.dart';
import 'package:trendify/services/network_services/base_api_service.dart';
import 'package:trendify/services/network_services/network_api_service.dart';

class ProductsRepository{
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllProducts() async{
    try{
      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.allProductsUrl);
      clearPrint(response.runtimeType.toString());
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> sortProducts() async{
    try{
      dynamic response = await _apiServices.getAPIResponse(ProductsUrl.sortDescProductUrl);
      clearPrint(response.runtimeType.toString());
      return response;
    }catch(e){
      rethrow;
    }
  }
}