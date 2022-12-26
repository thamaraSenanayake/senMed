import 'dart:io';

import 'package:balance/res.dart';

class StockModel{
  String id;
  String name;
  String stockType;
  List<String>? searchList;
  DateTime expire;
  int qty;
  double sellPrice;
  double buyingPrice;

  StockModel({this.searchList, required this.id,required this.stockType, required this.name, required this.expire, required this.qty, required this.sellPrice, required this.buyingPrice});


  Map<String, dynamic> toMap() {
    String searchTextValue = "";
    searchList = [];

    for (var i = 0; i < name.length; i++) {
      searchTextValue += name[i];
      searchList!.add(searchTextValue);
    }
    return {
      "id":id,
      "searchList":searchList,
      "name":name,
      "stockType":stockType,
      "expire":expire,
      "qty":qty,
      "sellPrice":sellPrice,
      "buyingPrice":buyingPrice,
    };
  }

  factory StockModel.fromMap(Map<String,dynamic> map) {
    
    return StockModel(
      id:map['id'],
      name:map['name'],
      stockType:map['stockType'],
      expire: getFirebaseTime(map['expire'])!,
      qty:map['qty'],
      sellPrice:map['sellPrice'],
      buyingPrice:map['buyingPrice'],
      
    );
  }
}