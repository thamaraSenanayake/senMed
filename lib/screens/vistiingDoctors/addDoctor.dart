import 'package:balance/model/doctorModel.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

class AddVisitingDoctors extends StatefulWidget {
  const AddVisitingDoctors({Key? key}) : super(key: key);

  @override
  State<AddVisitingDoctors> createState() => _VisitingDoctorsState();
}

class _VisitingDoctorsState extends State<AddVisitingDoctors> {
  String _doctorName ="";
  String _doctorNameError ="";
  String _hospital ="";
  String _hospitalError ="";
  String _contactNumber ="";
  String _contactNumberError ="";
  String _specialty ="";
  String _specialtyError ="";
  double _doctorsCharge =0.0;
  String _doctorsChargeError ="";
  
  
  final FocusNode _doctorNameFocus = FocusNode();
  final FocusNode _hospitalFocus = FocusNode();
  final FocusNode _contactNumberFocus = FocusNode();
  final FocusNode _specialtyFocus = FocusNode();
  final FocusNode _doctorsChargeFocus = FocusNode();

  final TextEditingController _doctorsChargeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

  

  _done() async {
    bool _validation = true;
    if(_doctorName.isEmpty){
      setState(() {
        _doctorNameError = "Required Field";
      });
      _validation= false;
    }
    if(_hospital.isEmpty){
      setState(() {
        _hospitalError = "Required Field";
      });
      _validation= false;
    }
    if(_contactNumber.isEmpty){
      setState(() {
        _contactNumberError = "Required Field";
      });
      _validation= false;
    }
    if(_specialty.isEmpty){
      setState(() {
        _specialtyError = "Required Field";
      });
      _validation= false;
    }
    if(_doctorsCharge == 0){
      setState(() {
        _doctorsChargeError = "Required Field";
      });
      _validation= false;
    }

    if(_validation){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      if( await Provider.of<FirebaseProvider>(context,listen: false).addVisitingDoctors(DoctorModel(hospital: _hospital, doctorsCharge: _doctorsCharge, doctorName: _doctorName, contactNumber: _contactNumber, specialty: _specialty))){
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
                          
                          CustomTextBox(
                            focusNode: _doctorNameFocus,
                            onChange: (val) {
                              _doctorName = val;
                              if (_doctorNameError.isNotEmpty) {
                                setState(() {
                                  _doctorNameError = "";
                                });
                              }
                            },
                            errorText: _doctorNameError,
                            width: _size.width - 40,
                            textBoxHint: "Doctor Name",
                            onSubmit: (val) {
                              _specialtyFocus.requestFocus();
                            },
                          ),

                          CustomTextBox(
                            focusNode: _specialtyFocus,
                            onChange: (val) {
                              _specialty = val;
                              if (_specialtyError.isNotEmpty) {
                                setState(() {
                                  _specialtyError = "";
                                });
                              }
                            },
                            errorText: _specialtyError,
                            width: _size.width - 40,
                            textBoxHint: "Specialty",
                            onSubmit: (val) {
                              _doctorsChargeFocus.requestFocus();
                            },
                          ),

                          CustomTextBox(
                            focusNode: _doctorsChargeFocus,
                            leftIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "LKR",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  // height: 1.5
                                ),
                              ),
                            ),
                            onChange: (val) {
                              if(double.tryParse(val) != null){
                                _doctorsCharge = double.parse(val);
                                if (_doctorsChargeError.isNotEmpty) {
                                  setState(() {
                                    _doctorsChargeError = "";
                                  });
                                }
                              }else{
                                _doctorsCharge = 0;
                              }
                            },
                            errorText: _doctorsChargeError,
                            width: _size.width - 40,
                            textBoxHint: "Doctors Charge",
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                            onSubmit: (val) {
                              _hospitalFocus.requestFocus();
                            },
                            onEditingComplete: (){
                              _doctorsChargeController.text =  _doctorsCharge.toStringAsFixed(2);
                            },
                          ),

                          
                          CustomTextBox(
                            focusNode: _hospitalFocus,
                            onChange: (val) {
                              _hospital = val;
                              if (_hospitalError.isNotEmpty) {
                                setState(() {
                                  _hospitalError = "";
                                });
                              }
                            },
                            errorText: _hospitalError,
                            width: _size.width - 40,
                            textBoxHint: "Hospital",
                            onSubmit: (val) {
                              _contactNumberFocus.requestFocus();
                            },
                          ),
                          
                          CustomTextBox(
                            focusNode: _contactNumberFocus,
                            onChange: (val) {
                              _contactNumber = val;
                              if (_contactNumberError.isNotEmpty) {
                                setState(() {
                                  _contactNumberError = "";
                                });
                              }
                            },
                            errorText: _contactNumberError,
                            width: _size.width - 40,
                            textBoxHint: "Contact Number",
                            onSubmit: (val) {
                              // _qtyFocus.requestFocus();
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CustomButton(title: "Done", onPress: () {_done();}),
                          )
                        ],
                      ),
                    ),),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child:Header(
                title: "Add Doctor",
                leftClick: (){
                  Get.back();
                },
                leftIcon:Icons.arrow_back,
                
              ),
          ),
          Loader(),
        ],
      ),
    );
  }
}
