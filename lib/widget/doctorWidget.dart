import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';

class DoctorWidget extends StatelessWidget {
  const DoctorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: AppColors.shadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "type",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Icon(
                Icons.call,
                color: AppColors.thirdColor,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}