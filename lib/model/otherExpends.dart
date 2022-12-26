class OtherExpends{
  String? id;
  String name;
  double doctorsCharge;
  double centerCharge;
  

  OtherExpends({required this.id,required this.name, required this.doctorsCharge, required this.centerCharge,});


  Map<String, dynamic> toMap() {
    
    return {
      "id":id,
      "name":name,
      "doctorsCharge":doctorsCharge,
      "centerCharge":centerCharge,
    };
  }

  factory OtherExpends.fromMap(Map<String,dynamic> map) {
    
    return OtherExpends(
      name:map["name"],
      id:map["id"],
      doctorsCharge:map["doctorsCharge"],
      centerCharge:map["centerCharge"],
    );
  }
}