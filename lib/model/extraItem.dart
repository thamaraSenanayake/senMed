import 'package:balance/res.dart';
import 'package:uuid/uuid.dart';

class ExtraItemModel{
  String? id;
  String extraItemName;
  double doctorsCharge;
  double centerCharge;
  
  ExtraItemModel({this.id, required this.extraItemName, required this.doctorsCharge, required this.centerCharge,});


  Map<String, dynamic> toMap() {
    
    return {
      "id":id,
      "extraItemName":extraItemName,
      "doctorsCharge":doctorsCharge,
      "centerCharge":centerCharge,
    };
  }

  factory ExtraItemModel.fromMap(Map<String,dynamic> map) {
    
    return ExtraItemModel(
      extraItemName:map["extraItemName"],
      id:map["id"],
      doctorsCharge:map["doctorsCharge"],
      centerCharge:map["centerCharge"],
    );
  }
}