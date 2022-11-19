import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';

class Header extends StatelessWidget {
  final Color leftIconColor;
  final String? rightIconText;
  final IconData? leftIcon;
  final Color rightIconColor;
  final Function? leftClick;
  final Function? rightClick;
  final String title;
  const Header({Key? key,this.leftIcon, this.rightIconText, this.leftClick, this.rightClick,required this.title,  this.leftIconColor = Colors.white, this.rightIconColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 54,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 13),
      color: AppColors.mainColor,
      child: Stack(
        children: [
          if(leftClick != null && leftIcon != null)
          GestureDetector(
            onTap: (){
              leftClick!();
            },
            child: Align(
              alignment: Alignment.centerLeft,
              // child: Icon(
              //   leftIcon!,
              //   color: leftIconColor,
              // ),
              child: Container(
                height: 30,
                width: 30,
                color: Colors.transparent,
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 12, 
                    width: 12, 
                    child: Icon(
                      leftIcon!,
                      color: AppColors.thirdColor,
                    )
                  ),
                ),
              ),
            ),
          ),
          if(rightClick != null)
          GestureDetector(
            onTap: (){
              rightClick!();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                // height: 30,
                width: 100,
                color: Colors.transparent,
                child:
                Center(
                  child: SizedBox(
                    // height: 20, 
                    width: 100, 
                    child: Text(
                     rightIconText!,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.thirdColor,
                      ),
                      textAlign: TextAlign.right,
                    )
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 30,
                // color: Colors.amber,
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: AppColors.thirdColor,
                    height: 1.5
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}