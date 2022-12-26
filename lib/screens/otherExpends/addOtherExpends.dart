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

class AddOtherExpends extends StatefulWidget {
  const AddOtherExpends({Key? key}) : super(key: key);

  @override
  State<AddOtherExpends> createState() => _AddOtherExpendsState();
}

class _AddOtherExpendsState extends State<AddOtherExpends> {
  String _reson = "";
  String _reasonError = "";
  double _cost = 0.0;
  String _costError = "";

  final FocusNode _costFocus = FocusNode();
  final FocusNode _reasonFocus = FocusNode();
  
  final TextEditingController _costController = TextEditingController();

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
                                _costFocus.requestFocus();
                              },
                              focusNode: _reasonFocus,
                              topPadding: false,
                              onEditingComplete: (){
                                
                               
                              },
                              onChange: (val){
                                
                              }, 
                              textBoxHint: "Reason",
                              errorText: _reasonError, 
                              width: _size.width-40
                            ),

                            CustomTextBox(
                              focusNode: _costFocus,
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
                              textEditingController: _costController,
                              onEditingComplete: (){
                                _costController.text= _cost.toStringAsFixed(2);
                              },
                              onChange: (val){
                                if (double.tryParse(val) != null) {
                                  _cost = double.parse(val);
                                  if (_costError.isNotEmpty) {
                                    setState(() {
                                      _costError = "";
                                    });
                                  }
                                } else {
                                  _cost = 0;
                                }
                              }, 
                              textBoxHint: "Doctors Charge",
                              errorText: _costError, 
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
              title: "Add Expends",
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
