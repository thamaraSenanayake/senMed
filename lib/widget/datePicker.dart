import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../res.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime dateTime;
  final Function(DateTime) setDateTime;
  const CustomDatePicker({Key? key, required this.dateTime, required this.setDateTime}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.dateTime;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){
          selectDate(
            context,
            _dateTime,
            (DateTime time){
              setState(() {
                _dateTime = time;
              });
              widget.setDateTime(_dateTime);
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
                Icons.date_range,
                color: AppColors.secondColor,
              ),
              const SizedBox(width: 10,),
              Text(
                DateFormat('MMM, d').format(_dateTime),
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