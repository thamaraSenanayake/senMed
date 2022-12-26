import 'package:balance/widget/datePicker.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:balance/widget/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

class AddExtraItem extends StatefulWidget {
  const AddExtraItem({Key? key}) : super(key: key);

  @override
  State<AddExtraItem> createState() => _AddExtraItemState();
}

class _AddExtraItemState extends State<AddExtraItem> {
  String _extraItem = "";
  String _extraItemError = "";
  double _docCharge = 0.0;
  String _docChargeError = "";
  double _centerCharge = 0.0;
  String _centerChargeError = "";

  final FocusNode _extraItemFocus = FocusNode();
  final FocusNode _docChargeFocus = FocusNode();
  final FocusNode _centerChargeFocus = FocusNode();

  
  final TextEditingController _docChargeController = TextEditingController();
  final TextEditingController _centerChargeController =  TextEditingController();

  @override
  void initState() {
    super.initState();
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
                              onSubmit: (val){
                                _docChargeFocus.requestFocus();
                              },
                              focusNode: _extraItemFocus,
                              topPadding: false,
                              onEditingComplete: (){
                                
                               
                              },
                              onChange: (val){
                                
                              }, 
                              textBoxHint: "Doctors Charge",
                              errorText: _docChargeError, 
                              width: _size.width-40
                            ),
                            CustomTextBox(
                              onSubmit: (val){
                                _centerChargeFocus.requestFocus();
                              },
                              focusNode: _docChargeFocus,
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
                              topPadding: false,
                              textEditingController: _docChargeController,
                              onEditingComplete: (){
                                
                                _docChargeController.text= _docCharge.toStringAsFixed(2);
                              },
                              onChange: (val){
                                if (double.tryParse(val) != null) {
                                  _docCharge = double.parse(val);
                                  if (_docChargeError.isNotEmpty) {
                                    setState(() {
                                      _docChargeError = "";
                                    });
                                  }
                                } else {
                                  _docCharge = 0;
                                }
                              }, 
                              textBoxHint: "Doctors Charge",
                              errorText: _docChargeError, 
                              width: _size.width-40
                            ),

                            CustomTextBox(
                              focusNode: _centerChargeFocus,
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
                              topPadding: false,
                              textEditingController: _centerChargeController,
                              onEditingComplete: (){
                                
                                _centerChargeController.text= _centerCharge.toStringAsFixed(2);
                              },
                              onChange: (val){
                                if (double.tryParse(val) != null) {
                                  _centerCharge = double.parse(val);
                                  if (_centerChargeError.isNotEmpty) {
                                    setState(() {
                                      _centerChargeError = "";
                                    });
                                  }
                                } else {
                                  _centerCharge = 0;
                                }
                              }, 
                              textBoxHint: "Center Charge",
                              errorText: _docChargeError, 
                              width: _size.width-40
                            ),
                            
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child:
                                  CustomButton(title: "Done", onPress: () {}),
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
              title: "Add Feature",
              leftClick: () {
                Get.back();
              },
              leftIcon: Icons.arrow_back,
            ),
          )
        ],
      ),
    );
  }

  
}
