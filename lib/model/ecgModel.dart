import 'package:balance/res.dart';
import 'package:uuid/uuid.dart';

class ECGModel{
  String? id;
  String name;
  String age;
  int amount;
  String? incomeId;
  DateTime dateTime;

  ECGModel({ this.incomeId, this.id, required this.dateTime,required this.name, required this.age, required this.amount,});


  Map<String, dynamic> toMap() {
    
    return {
      "id":id,
      "name":name,
      "age":age,
      "amount":amount,
      "dateTime":dateTime,
      "incomeId":incomeId,
    };
  }

  factory ECGModel.fromMap(Map<String,dynamic> map) {
    
    return ECGModel(
      name:map["name"],
      incomeId:map["incomeId"],
      id:map["id"],
      age:map["age"],
      amount:map["amount"],
      dateTime: getFirebaseTime(map['dateTime'])!,      
    );
  }
}