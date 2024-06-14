// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/services/api_url.dart';
import 'package:trendify/services/network_services/base_api_service.dart';
import 'package:trendify/services/network_services/network_api_service.dart';
import 'package:trendify/widgets/widget_components.dart';

class AuthRepository{
  final BaseApiServices _apiServices = NetworkApiService();

  Future<bool> login({required dynamic data, required BuildContext context}) async{
    try{
      dynamic response = await _apiServices.postApiResponse(AuthUrl.loginUrl, data);
      clearPrint(response.toString());
      return true;
    }catch(e){
      WidgetComponents.showSnackBarForFeedback(cntxt: context, message: "Invalid Credentials", isError: true);
      return false;
    }
  }
}