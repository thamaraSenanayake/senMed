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
import 'package:uuid/uuid.dart';
import '../../model/doctorModel.dart';
import '../../model/patientModel.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

class AddPatient extends StatefulWidget {
  final List<PatientModel> patientList;
  final String channelingId; 
  const AddPatient({Key? key, required this.patientList, required this.channelingId}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  String _patientName = "";
  String _patientNameError= "";
  String _contactNum = "";
  String _contactNumError= "";

  _done() async {
    bool _validation = true; 
    if(_patientName.isEmpty){
      setState(() {
        _patientNameError = "Required Field";
      });
      _validation = false;
    }
    else if(_contactNum.isEmpty){
      setState(() {
        _contactNumError = "Required Field";
      });
      _validation = false;
    }
    if(_validation){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      widget.patientList.add(PatientModel(isCanceled: false, isPaid: false, otherExpendsList: [], id: Uuid().v4(), name: _patientName, telephone: _contactNum));

      if(await Provider.of<FirebaseProvider>(context,listen: false).addPatientChannelData(widget.patientList, widget.channelingId)){
        Get.back(result:widget.patientList);
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
                            CustomTextBox(
                              onChange: (val){
                                _patientName = val;
                                if(_patientNameError.isEmpty){
                                  setState(() {
                                    _patientNameError = "";
                                  });
                                }
                              }, 
                              errorText: _patientNameError, 
                              width: _size.width-40,
                              textBoxHint: "Patient Name",
                            ),
                            CustomTextBox(
                              onChange: (val){
                                _contactNum = val;
                                if(_contactNumError.isEmpty){
                                  setState(() {
                                    _contactNumError = "";
                                  });
                                }
                              }, 
                              errorText: _contactNumError, 
                              width: _size.width-40,
                              textBoxHint: "Patient Contact Num",
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
