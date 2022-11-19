import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final Function onPress;
  const CustomButton({Key? key, required this.title, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        onPress();
      },
      child: Container(
        width: _size.width - 40,
        height: 48,
        decoration:BoxDecoration(
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
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.nunito(
              color: AppColors.thirdColor,
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
}