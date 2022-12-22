import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/base_provider.dart';
import '../res.dart';

class BasePageElement extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  const BasePageElement({Key? key, required this.image, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return            
      GestureDetector(
        onTap: ()=>
          onTap(),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 184,
            maxWidth: 184,
            minHeight: 120,
            minWidth: 120,
          ),
          height: _size.width/2-30,
          width: _size.width/2-30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: AppColors.secondColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}