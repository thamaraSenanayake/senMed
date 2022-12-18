import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay timeOfDay;
  final Function(TimeOfDay) setTimeOfDay;
  const CustomTimePicker({Key? key, required this.timeOfDay, required this.setTimeOfDay}) : super(key: key);

  @override
  State<CustomTimePicker> createState() => CustomTimePickerState();
}

class CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay _timeOfDay;

  @override
  void initState() {
    super.initState();
    _timeOfDay = widget.timeOfDay;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){
          timePicker(
            context,
            _timeOfDay,
            (TimeOfDay time){
              setState(() {
                widget.setTimeOfDay(time);
              });
            }
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          padding:const EdgeInsets.only(
            left:20,
            right:20
          ),
          decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15)),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 11.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              )
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.access_time,
                color: AppColors.secondColor,
              ),
              const SizedBox(width: 10,),
              Text(
                _timeOfDay.format(context),
                style: GoogleFonts.poppins(
                  color: Colors.black, 
                  fontSize: 14,
                  fontWeight:FontWeight.w400
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}