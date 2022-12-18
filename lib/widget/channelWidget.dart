import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res.dart';

class ChannelWidget extends StatelessWidget {
  final Function onClick;
  const ChannelWidget({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "10",
                        style: GoogleFonts.poppins(
                          color: AppColors.thirdColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr.Gayan De Silva",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "(V.P) - Chilaw",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Jul 10 - 10.00 a.m",
                        style: GoogleFonts.poppins(
                          color: AppColors.secondColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.thirdColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}