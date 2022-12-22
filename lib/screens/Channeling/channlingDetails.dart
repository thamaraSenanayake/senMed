import 'package:animations/animations.dart';
import 'package:balance/const.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/channelPatient/channelPatient.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/datePicker.dart';
import '../../widget/timePicker.dart';
import 'addChanneling.dart';

class ChannelingDetails extends StatefulWidget {
  const ChannelingDetails({Key? key}) : super(key: key);

  @override
  State<ChannelingDetails> createState() => _ChannelingDetailsState();
}

class _ChannelingDetailsState extends State<ChannelingDetails> {

  bool _editTimeDisplay = false;

  @override
  void initState() {
    super.initState();

    _initSate();
  }

  _initSate() async {}
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Time",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Jul 10 - 10.00 a.m",
                                style: GoogleFonts.poppins(
                                  color: AppColors.secondColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _editTimeDisplay = !_editTimeDisplay;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: AppColors.shadow,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.thirdColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      if(_editTimeDisplay)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text(
                                "Update Date & time",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),

                              CustomDatePicker(
                                dateTime: DateTime.now(), 
                                setDateTime: (DateTime  dateTime) {
                                  // _dateTime = dateTime;
                                },
                              ),
                              CustomTimePicker(
                                timeOfDay: TimeOfDay.now(), 
                                setTimeOfDay: (TimeOfDay timeOfDay){
                                  setState(() {
                                    // _timeOfDay = timeOfDay;
                                  });
                                }
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              CustomButton(
                                title: "Done", 
                                onPress: (){
                                  setState(() {
                                    _editTimeDisplay = false;
                                  });
                                }
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Doctor's Payment",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "LKR 8000.00",
                              style: GoogleFonts.poppins(
                                color: AppColors.secondColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: _size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Info",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "VOG - Chilaw Hospital",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Column(
                        children: [
                          ChannelPatient()
                        ],
                      )




                    ],
                  ),
                ),),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
