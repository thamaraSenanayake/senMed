import 'package:balance/res.dart';
import 'package:uuid/uuid.dart';

class ECGModel{
  String id;
  String name;
  String age;
  int amount;
  DateTime dateTime;

  ECGModel({required this.id, required this.dateTime,required this.name, required this.age, required this.amount,});


  Map<String, dynamic> toMap() {
    String _id=  Uuid().v4();
    return {
      "id":_id,
      "name":name,
      "age":age,
      "amount":amount,
      "dateTime":dateTime,
    };
  }

  factory ECGModel.fromMap(Map<String,dynamic> map) {
    
    return ECGModel(
      name:map["name"],
      id:map["id"],
      age:map["age"],
      amount:map["amount"],
      dateTime: getFirebaseTime(map['dateTime'])!,      
    );
  }
}