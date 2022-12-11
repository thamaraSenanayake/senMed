import 'package:balance/res.dart';
import 'package:uuid/uuid.dart';

class Prescription{
  String name;
  String does;
  int days;

  Prescription({required this.name, required this.does,required this.days});


  Map<String, dynamic> toMap() {
    return {
      "name":name,
      "does":does,
      "days":days,
    };
  }

  factory Prescription.fromMap(Map<String,dynamic> map) {
    
    return Prescription(
      name:map["name"],
      does:map["does"],
      days:map["days"],
    );
  }
}