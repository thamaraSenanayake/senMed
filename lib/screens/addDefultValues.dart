import 'package:animations/animations.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDefault extends StatefulWidget {
  const AddDefault({Key? key}) : super(key: key);

  @override
  State<AddDefault> createState() => _AddDefaultState();
}

class _AddDefaultState extends State<AddDefault> {

  double _ecgPrice = 0.0;
  String _ecgPriceError ="";
  double _channelingPrice = 0.0;
  String _channelingPriceError ="";

  final TextEditingController _ecgController = TextEditingController();
  final TextEditingController _channelingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 100,
          color: AppColors.mainColor,
        ),
        SafeArea(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Text(
                        "ECG Charging",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      CustomTextBox(
                        textEditingController: _ecgController,
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
                        onEditingComplete: (){
                          _ecgController.text= _ecgPrice.toStringAsFixed(2);
                        },
                        topPadding: false,
                        onChange: (val){
                          if (double.tryParse(val) != null) {
                            _ecgPrice = double.parse(val);
                            if (_ecgPriceError.isNotEmpty) {
                              setState(() {
                                _ecgPriceError = "";
                              });
                            }
                          } else {
                            _ecgPrice = 0;
                          }
                        }, 
                        errorText: _ecgPriceError, 
                        width: _size.width-40,
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        "Doctors Charging",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      CustomTextBox(
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
                        textEditingController: _channelingController,
                        onEditingComplete: (){
                          print(_channelingPrice.toStringAsFixed(2));
                          _channelingController.text= _channelingPrice.toStringAsFixed(2);
                        },
                        onChange: (val){
                          if (double.tryParse(val) != null) {
                            _channelingPrice = double.parse(val);
                            if (_channelingPriceError.isNotEmpty) {
                              setState(() {
                                _channelingPriceError = "";
                              });
                            }
                          } else {
                            _channelingPrice = 0;
                          }
                        }, 
                        errorText: _ecgPriceError, 
                        width: _size.width-40
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}
