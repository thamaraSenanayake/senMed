import 'package:balance/widget/button.dart';
import 'package:balance/res.dart';
import 'package:balance/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/base_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _EcgScreenState();
}

class _EcgScreenState extends State<SettingsScreen> {
  
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 100,
          color: AppColors.mainColor,
        ),
        SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            height: _size.height,
            width: _size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                  
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.VisitingDoctors);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Visiting Doctors",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.secondColor,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.DefaultValues);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.numbers,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Default Values",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.secondColor,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.ChannelingExtraItems);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.extension_rounded,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Channeling Extra Items",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.secondColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}
