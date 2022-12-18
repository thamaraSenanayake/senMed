import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import '../res.dart';

class Logout extends StatelessWidget {
  
  const Logout({Key? key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      content: Container(
        width: 260.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            // dialog centre
            Column(
              children: <Widget>[
                Text(
                  'Are you sure you want to logout?',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  // textAlign: TextAlign.center,
                ),
                
              ],
            ),

            Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: <Widget>[
                // dialog button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context,true);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // dialog button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context,false);
                  },
                  child: Container(
                    child:const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ]
            ),
          ],
        ),
      ),
    );
  }
}


