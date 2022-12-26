import 'package:balance/model/prescription.dart';
import 'package:balance/res.dart';
import 'package:uuid/uuid.dart';

class PPModel{
  String id;
  String? incomeId;
  String name;
  String age;
  List<Prescription> prescriptionList;
  int bp;
  int dressing;
  int otherExpends;
  int doctorsCharge;
  int medicineCharge;
  DateTime dateTime;

  PPModel({this.incomeId, required this.medicineCharge,required this.bp,required this.dressing, required this.otherExpends, required this.doctorsCharge, required this.id, required this.dateTime,required this.name, required this.age, required this.prescriptionList});


  Map<String, dynamic> toMap() {
    String _id=  Uuid().v4();
    List<Map<String,dynamic>> _prescriptionList =[];
    for (var element in prescriptionList) {
      _prescriptionList.add(element.toMap());
    }
    return {
      "id":_id,
      "name":name,
      "incomeId":incomeId,
      "age":age,
      "prescriptionList":_prescriptionList,
      "bp":bp,
      "dressing":dressing,
      "otherExpends":otherExpends,
      "doctorsCharge":doctorsCharge,
      "dateTime":dateTime,
      "medicineCharge":medicineCharge,
    };
  }

  factory PPModel.fromMap(Map<String,dynamic> map) {
    List<Prescription> _prescriptionList = [];
    for (var element in map["prescriptionList"]) {
      _prescriptionList.add(Prescription.fromMap(element));
    }
    return PPModel(
      id:map["id"],
      incomeId:map["incomeId"],
      medicineCharge:map["medicineCharge"],
      name:map["name"],
      age:map["age"],
      prescriptionList:_prescriptionList,
      bp:map["bp"],
      dressing:map["dressing"],
      otherExpends:map["otherExpends"],
      doctorsCharge:map["doctorsCharge"],
      dateTime: getFirebaseTime(map['dateTime'])!,      
    );
  }
}