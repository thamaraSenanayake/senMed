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

class AddChanneling extends StatefulWidget {
  const AddChanneling({Key? key}) : super(key: key);

  @override
  State<AddChanneling> createState() => _AddChannelingState();
}

class _AddChannelingState extends State<AddChanneling> {
  String _docName = "";
  String _docType = "";
  double _docChrage = 0;
  late DateTime _dateTime;
  late TimeOfDay _timeOfDay;

  @override
  void initState() {
    _dateTime = DateTime.now();
    _timeOfDay = TimeOfDay.now();
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
                            CustomDropDown(
                              hint: "Select Doctor",
                              value: null,
                              valueList: [],
                              onChange: (val) {
                                setState(() {
                                  _docName = val;
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
              title: "Add Channel",
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
