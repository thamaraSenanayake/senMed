import 'otherExpends.dart';

class PatientModel{
  String? id;
  String name;
  String telephone;
  bool isPaid;
  bool isCanceled;
  List<OtherExpends> otherExpendsList;

  PatientModel({required this.isCanceled, required this.isPaid,required this.otherExpendsList,required this.id,required this.name, required this.telephone});


  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> _list = [];
    
    for (var element in otherExpendsList) {
      _list.add(element.toMap());
    }

    return {
      "id":id,
      "isPaid":isPaid,
      "isCanceled":isCanceled,
      "name":name,
      "telephone":telephone,
      "otherExpendsList":_list,
      
    };
  }

  factory PatientModel.fromMap(Map<String,dynamic> map) {
    List<OtherExpends> _otherExpendsList = [];
    for (var element in map['otherExpendsList']) {
      _otherExpendsList.add(OtherExpends.fromMap(element));
    }
    return PatientModel(
      id:map["id"],
      isPaid:map["isPaid"],
      isCanceled:map["isCanceled"],
      name:map["name"],
      telephone:map["telephone"],
      otherExpendsList:_otherExpendsList  
    );
  }
}