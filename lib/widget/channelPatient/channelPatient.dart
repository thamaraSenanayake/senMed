import 'package:balance/model/patientModel.dart';
import 'package:balance/widget/channelPatient/otherCharges.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res.dart';

class ChannelPatient extends StatefulWidget {
  final PatientModel patientModel;
  const ChannelPatient({Key? key, required this.patientModel}) : super(key: key);

  @override
  State<ChannelPatient> createState() => _ChannelPatientState();
}

class _ChannelPatientState extends State<ChannelPatient> {

  bool _isMoreClicked = false;
  bool _isPaid = false;
  List<Widget> _otherChargesList = [OtherCharges(removeOtherCharge: (){},)];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.shadow,
        borderRadius: BorderRadius.circular(5),
      ),
     
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Mr/Mrs ${widget.patientModel.name}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),

              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "1",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))
                    ),
                    child: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _isPaid = !_isPaid;
                      });
                    },
                    child: AnimatedContainer(
                      height: 30,
                      width: 100,
                      duration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                        color: _isPaid?Colors.green:  AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:_isPaid?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 5,),
                          Text(
                            "Paid",
                            style: GoogleFonts.poppins(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ):  Center(
                        child: Text(
                          "Not Paid",
                          style: GoogleFonts.poppins(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    "LKR 2300.00",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _isMoreClicked =!_isMoreClicked;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Text(
                          "More",
                          style: GoogleFonts.poppins(
                            color: AppColors.secondColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          _isMoreClicked? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                          color: AppColors.secondColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          if(_isMoreClicked)
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8,top: 10),
            child: Column(
              children: [
                Column(
                  children:_otherChargesList ,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          _otherChargesList.add(OtherCharges(removeOtherCharge: (){},));
                          setState(() {
                            
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.thirdColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}