import 'dart:io';

import 'package:balance/res.dart';

class StockModel{
  String id;
  String name;
  DateTime expire;
  int qty;
  double sellPrice;
  double buyingPrice;

  StockModel({required this.id, required this.name, required this.expire, required this.qty, required this.sellPrice, required this.buyingPrice});


  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name":name,
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
      expire: getFirebaseTime(map['expire'])!,
      qty:map['qty'],
      sellPrice:map['sellPrice'],
      buyingPrice:map['buyingPrice'],
      
    );
  }
}