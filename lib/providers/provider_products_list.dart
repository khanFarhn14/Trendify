import 'package:flutter/material.dart';
import 'package:trendify/resources.dart';

class ProductList extends ChangeNotifier{
  List<dynamic> productsList = [];

  void updateProductsList({required List<dynamic> list}){
    productsList = list;
    clearPrint(productsList.length.toString());
    notifyListeners();
  }
}