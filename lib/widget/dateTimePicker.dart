import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../res.dart';


class DateTimePickerView extends StatefulWidget {
  final String textBoxHint;
  final DateTime? initText;
  final String errorText;
  final Function(DateTime) onChange;
  final int? maxLength;
  final double width;
  final double height;
  final double fontSize;
  
  const DateTimePickerView({
    Key? key,
    required this.onChange,
    this.fontSize=15,
    required this.textBoxHint,
    this.initText,
    this.height = 50,
    // this.shadow = true,
    this.maxLength,

    required this.width, 
    required this.errorText, 
  }) : super(key: key);

  @override
  _DateTimePickerViewState createState() => _DateTimePickerViewState();
}

class _DateTimePickerViewState extends State<DateTimePickerView> {
  late final double _fontSize = widget.fontSize;
  DateTime? _dateTime;

   Future<void> _selectDate(BuildContext context) async {
    if(widget.initText == null){
      _dateTime = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime??DateTime.now(),
        firstDate: DateTime(1948, 8),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme:const ColorScheme.dark(
                  primary: AppColors.thirdColor,
                  onPrimary: Colors.white,
                  surface: AppColors.secondColor,
                  onSurface: Colors.black,
                  ),
              dialogBackgroundColor:AppColors.backGroundColor,
            ),
            child: child!,
          );
        },
      );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
      widget.onChange(_dateTime!);
    }
  }
  
  @override
  void initState() { 
    super.initState();
    if(widget.initText != null){
      _dateTime = widget.initText;
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.initText == null){
      _dateTime = null;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: (){
          _selectDate(context);
          
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 48,
          padding:const EdgeInsets.only(
            left: 10 ,
            right: 10
          ),
          decoration: BoxDecoration(
            // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
            color: Colors.white,
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
            
            border: Border.all(
              color: widget.errorText.isEmpty?
                      (Colors.transparent):
                      Colors.redAccent,
              width:(1)
            ),
            borderRadius: BorderRadius.circular(4),
            
            
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              const Padding(
                padding:  EdgeInsets.only(right:10),
                child:  Icon(
                  Icons.calendar_month_outlined,
                  color:AppColors.thirdColor,
                ),
              ),
              
              Expanded(
                child: _dateTime != null? Text(
                  DateFormat.yMMMMd('en_US').format(_dateTime!),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black
                  ),
                ):Text(
                  widget.textBoxHint,
                  style: GoogleFonts.poppins(
                    fontSize:12, 
                    color: Colors.grey, 
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              
              
              
            ],
          ),
        ),
      ),
    );
  }
}
