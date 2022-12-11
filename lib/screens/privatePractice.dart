import 'package:balance/model/prescription.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/prescriptionWidget.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res.dart';
import '../widget/button.dart';
import '../widget/header.dart';

class PrivatePractice extends StatefulWidget {
  const PrivatePractice({Key? key}) : super(key: key);

  @override
  State<PrivatePractice> createState() => _PrivatePracticeState();
}

class _PrivatePracticeState extends State<PrivatePractice> {
  String _name = "";
  String _nameError = "";
  String _age = "";
  String _ageError = "";
  bool _isMale = true;
  bool _isExtraView = false;
  List<Prescription> _prescriptionList = [Prescription(days: 0, does: AppData.dose[0], name: '')];

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  _validation(){
    //todo
      _prescriptionList.add(Prescription(days: 0, does: AppData.dose[0], name: ''));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
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
                      focusNode: _nameFocus,
                      onChange: (val) {
                        _name = val;
                        if (_nameError.isNotEmpty) {
                          setState(() {
                            _nameError = "";
                          });
                        }
                      },
                      errorText: _nameError,
                      width: _size.width - 40,
                      textBoxHint: "Name",
                      onSubmit: (val) {
                        _ageFocus.requestFocus();
                      },
                    ),
                    CustomTextBox(
                      focusNode: _ageFocus,
                      onChange: (val) {
                        _name = val;
                        if (_nameError.isNotEmpty) {
                          setState(() {
                            _nameError = "";
                          });
                        }
                      },
                      errorText: _nameError,
                      width: _size.width - 40,
                      textBoxHint: "Age",
                      onSubmit: (val) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: _size.width,
                        child: Text(
                          "Prescription",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _prescriptionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PrescriptionWidget(
                            prescription: _prescriptionList[index], 
                            addDisplay: _prescriptionList.last == _prescriptionList[index], 
                            addNew: (){
                              _validation();
                            },
                          );
                        }
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30,),
                      child: SizedBox(
                        width: _size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Extra",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _isExtraView = !_isExtraView;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.mainColor
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    _isExtraView ?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
                                    color: AppColors.thirdColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    if(_isExtraView)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          CustomTextBox(
                            onChange: (val){

                            }, 
                            errorText: "", 
                            textBoxHint: "BP",
                            width: _size.width - 40,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                            leftIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "LKR",
                                style: GoogleFonts.poppins(
                                  fontSize:13, 
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500,
                                  // height: 1.5
                                ),
                              )
                            ),
                          ),
                          CustomTextBox(
                            onChange: (val){

                            }, 
                            errorText: "", 
                            textBoxHint: "Dressing",
                            width: _size.width - 40,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                            leftIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "LKR",
                                style: GoogleFonts.poppins(
                                  fontSize:13, 
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500,
                                  // height: 1.5
                                ),
                              )
                            ),
                          ),
                          CustomTextBox(
                            leftIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "LKR",
                                style: GoogleFonts.poppins(
                                  fontSize:13, 
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w500,
                                  // height: 1.5
                                ),
                              )
                            ),
                            onChange: (val){

                            }, 
                            errorText: "", 
                            textBoxHint: "Other",
                            width: _size.width - 40,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ],
                      ),
                    ),

                    CustomTextBox(
                      onChange: (val){

                      }, 
                      errorText: "", 
                      textBoxHint: "Doctors Charge",
                      width: _size.width - 40,
                      textInputType: const TextInputType.numberWithOptions(decimal: true),
                      leftIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "LKR",
                          style: GoogleFonts.poppins(
                            fontSize:13, 
                            color: Colors.black, 
                            fontWeight: FontWeight.w500,
                            // height: 1.5
                          ),
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30,),
                      child: SizedBox(
                        width: _size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total Cost",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "LKR: 300.00",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CustomButton(title: "Done", onPress: () {}),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
