import 'package:balance/model/channelingModel.dart';
import 'package:balance/widget/datePicker.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:balance/widget/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/doctorModel.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

class AddChanneling extends StatefulWidget {
  const AddChanneling({Key? key}) : super(key: key);

  @override
  State<AddChanneling> createState() => _AddChannelingState();
}

class _AddChannelingState extends State<AddChanneling> {
  String? _docName;
  String _doctorNameError="";
  String _docType = "";
  double _docChrage = 0;
  late DateTime _dateTime;
  late TimeOfDay _timeOfDay;
  List<String> _doctorNameList = [];
  List<DoctorModel> _doctorList = [];

  @override
  void initState() {
    _dateTime = DateTime.now();
    _timeOfDay = TimeOfDay.now();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadDoctors();
    });
    
  }

  _loadDoctors() async {
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _doctorList = await Provider.of<FirebaseProvider>(context,listen: false).getVisitingDoctorList();
    for (var element in _doctorList) {
      _doctorNameList.add(element.doctorName);
    }
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
  }

  _done() async {
    if(_docName == null){
      setState(() {
        _doctorNameError = "Required Field";
      });
    }else {
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      DoctorModel _doctor = _doctorList.firstWhere((element) => element.doctorName == _docName);
      if(await Provider.of<FirebaseProvider>(context,listen: false).addChannelData(ChannelingModel(isOnGoing: true, dateTime: _dateTime, doctorPayment: _doctor.doctorsCharge, hospital: _doctor.hospital, specialty: _doctor.specialty, patientList: [], doctorName: _doctor.doctorName, telephone: _doctor.contactNumber))){
        Get.back();
      }
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("Add Stock")),
      body: Stack(
        children: [
          Container(
            height: 100,
            color: AppColors.mainColor,
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                color: Colors.white,
                height: _size.height,
                width: _size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            CustomDropDown(
                              errorText: _doctorNameError,
                              hint: "Select Doctor",
                              value: _docName,
                              valueList: _doctorNameList,
                              onChange: (val) {
                                setState(() {
                                  _docName = val;
                                  _doctorNameError ="";
                                });
                              },
                            ),
                            CustomDatePicker(
                              dateTime: _dateTime, 
                              setDateTime: (DateTime  dateTime) {
                                _dateTime = dateTime;
                              },
                            ),
                            CustomTimePicker(
                              timeOfDay: _timeOfDay, 
                              setTimeOfDay: (TimeOfDay timeOfDay){
                                setState(() {
                                  _timeOfDay = timeOfDay;
                                });
                              }
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child:
                                  CustomButton(title: "Done", onPress: () {_done();}),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Header(
              title: "Add Channel",
              leftClick: () {
                Get.back();
              },
              leftIcon: Icons.arrow_back,
            ),
          ),
          Loader()
        ],
      ),
    );
  }

  
}
