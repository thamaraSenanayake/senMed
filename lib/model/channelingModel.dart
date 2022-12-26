import '../res.dart';
import 'otherExpends.dart';
import 'patientModel.dart';

class ChannelingModel{
  String? id;
  String doctorName;
  String specialty;
  String hospital;
  String telephone;
  double doctorPayment;
  DateTime dateTime;
  List<PatientModel> patientList;

  ChannelingModel({required this.dateTime,required this.doctorPayment,required this.hospital,required this.specialty,required this.patientList,required this.id,required this.doctorName, required this.telephone});


  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> _list = [];
    
    for (var element in patientList) {
      _list.add(element.toMap());
    }

    return {
      "id":id,
      "doctorName":doctorName,
      "specialty":specialty,
      "hospital":hospital,
      "telephone":telephone,
      "doctorPayment":doctorPayment,
      "dateTime":dateTime,
      "patientList":_list,
      
    };
  }

  factory ChannelingModel.fromMap(Map<String,dynamic> map) {
    List<PatientModel> _patientList = [];
    for (var element in map['patientList']) {
      _patientList.add(PatientModel.fromMap(element));
    }
    return ChannelingModel(
      id:map["id"],
      doctorName:map["doctorName"],
      specialty:map['specialty'],
      hospital:map['hospital'],
      telephone:map['telephone'],
      doctorPayment:map['doctorPayment'],
      patientList:_patientList,
      dateTime: getFirebaseTime(map['dateTime'])!, 
    );
  }
}