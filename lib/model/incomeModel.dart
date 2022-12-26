import 'package:balance/res.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Income{
  String? id;
  bool isIncome;
  double amount;
  String incomeType;
  String? monthYear;
  String? year;
  DateTime? dateTime;

  Income({required this.incomeType,required this.id,required this.isIncome, required this.amount,required, this.monthYear, this.year,  this.dateTime,});


  Map<String, dynamic> toMap() {
    dateTime = DateTime.now();
    monthYear = DateFormat('y/M').format(dateTime!);
    year = DateFormat('y').format(dateTime!);
    return {
      "id":id,
      "isIncome":isIncome,
      "monthYear":monthYear,
      "year":year,
      "amount":amount,
      "dateTime":dateTime,
      "incomeType":incomeType,
    };
  }

  factory Income.fromMap(Map<String,dynamic> map) {
    
    return Income(
      isIncome:map["isIncome"],
      incomeType:map["incomeType"],
      id:map["id"],
      monthYear:map["monthYear"],
      year:map["year"],
      amount:map["amount"],
      dateTime: getFirebaseTime(map['dateTime'])!,      
    );
  }
}

class IncomeType{
  static const String ecg = "ECG";
  static const String channeling = "Channeling";
  static const String pp = "PP";

  static const String salary = "salary";
  static const String otherExpends = "otherExpends";
}