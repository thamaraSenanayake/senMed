import 'package:balance/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../dialog/logout.dart';
import '../providers/base_provider.dart';
import '../res.dart';

List<Widget> appDrawerContent(GlobalKey<ScaffoldState> globalKey,BuildContext context) {
  return [
    Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: SizedBox(
            height: 100,
            width: 200,
            child: Image.asset("assets/image/logo.png"),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            "Senanayake Medicals",
            style: GoogleFonts.poppins(
              color: AppColors.mainColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(
          height: 30,
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: GestureDetector(
            onTap: ()  {
              globalKey.currentState!.openEndDrawer();
              Provider.of<BaseProvider>(context, listen: false).setProfilePage(Pages.Settings);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.settings,
                    color: AppColors.secondColor,
                  ),
                  SizedBox(width: 18),
                  Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: GestureDetector(
            onTap: () async {
              globalKey.currentState!.openEndDrawer();
              bool? val = await Get.generalDialog(pageBuilder: (context, _, __) {
                return const Logout();
              });
              if (val == true) {
                await Provider.of<FirebaseProvider>(context, listen: false).signOut();
                
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.login_outlined,
                    color: AppColors.secondColor,
                  ),
                  SizedBox(width: 18),
                  Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    )
  ];
}
