import 'dart:io';

import 'package:balance/res.dart';

class StockModel{
  String? id;
  String name;
  List<String>? searchList;
  String stockType;
  int qty;
  int waringQtyLimit;
  double sellPrice;

  StockModel({this.searchList,  this.id,required this.waringQtyLimit, required this.stockType, required this.name, required this.qty, required this.sellPrice});


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
      "qty":qty,
      "sellPrice":sellPrice,
      "waringQtyLimit":waringQtyLimit,
    };
  }

  factory StockModel.fromMap(Map<String,dynamic> map) {
    
    return StockModel(
      id:map['id'],
      name:map['name'],
      stockType:map['stockType'],
      qty:map['qty'],
      sellPrice:map['sellPrice'],
      waringQtyLimit:map['waringQtyLimit'],
      
    );
  }
}