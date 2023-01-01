import 'package:balance/model/ecgModel.dart';
import 'package:balance/model/ppModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';

class PPHistoryWidget extends StatefulWidget {
  final Function onClick;
  final PPModel ppModel;
  const PPHistoryWidget({key, required this.onClick, required this.ppModel}) : super(key: key);

  @override
  State<PPHistoryWidget> createState() => _PPHistoryWidgetState();
}

class _PPHistoryWidgetState extends State<PPHistoryWidget> {
  bool _isMoreDisplay = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){
          widget.onClick();
        },
        child: Container(
          width: MediaQuery.of(context).size.width-40,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ppModel.name,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Age: ${widget.ppModel.age}",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _isMoreDisplay =!_isMoreDisplay;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Icon(
                        _isMoreDisplay ?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
                        color: AppColors.thirdColor,
                      ),
                    ),
                  )
                ],
              ),
              if(_isMoreDisplay)
              Padding(
                padding: const EdgeInsets.only(top: 20,),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(widget.ppModel.prescriptionList.isNotEmpty)
                      Text(
                        "Prescription",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if(widget.ppModel.prescriptionList.isNotEmpty)
                      MediaQuery.removePadding(
                        context: context, 
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.ppModel.prescriptionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Text(
                                  "${widget.ppModel.prescriptionList[index].name} ${widget.ppModel.prescriptionList[index].does} for ${widget.ppModel.prescriptionList[index].days} days",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            );
                          } 
                        ),
                      ),

                      if(widget.ppModel.bp>0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Check Blood Pressure: 120-80",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      if(widget.ppModel.dressing>0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Done Dressing",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}