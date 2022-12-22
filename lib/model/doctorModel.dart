import 'package:uuid/uuid.dart';

class DoctorModel{
  String id;
  String doctorName;
  String hospital;
  String contactNumber;
  String specialty;
  double doctorsCharge;

  DoctorModel({required this.hospital, required this.id, required this.doctorsCharge,required this.doctorName, required this.contactNumber, required this.specialty,});


  Map<String, dynamic> toMap() {
    String _id=  Uuid().v4();
    return {
      "id":_id,
      "doctorName":doctorName,
      "hospital":hospital,
      "contactNumber":contactNumber,
      "specialty":specialty,
      "doctorsCharge":doctorsCharge,
    };
  }

  factory DoctorModel.fromMap(Map<String,dynamic> map) {
    
    return DoctorModel(
      id:map["id"],
      doctorName:map["doctorName"],
      hospital:map["hospital"],
      contactNumber:map["contactNumber"],
      specialty:map["specialty"],
      doctorsCharge: (map['doctorsCharge'])!,      
    );
  }
}