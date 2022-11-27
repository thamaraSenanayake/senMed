import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import '../widget/dropDown.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late String _selectedStockItem;
  @override
  void initState() {
    super.initState();
    _selectedStockItem = AppData.stockList[0];
    _initSate();
  }

  _initSate() async {}
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimationLimiter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                
                  children: [
                    CustomDropDown(
                      value: _selectedStockItem, 
                      valueList: AppData.stockList, 
                      onChange: (String val) {  
                        _selectedStockItem = val;
                      },

                    ),
                    CustomTextBox(
                      onChange: (val){
                        
                      }, 
                      errorText: "",
                      width: _size.width-40,
                      textBoxHint: "Search",
                      rightIcon: Icons.search,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: _size.height-282,
                        child: MediaQuery.removePadding(
                          context: context, 
                          removeTop: true,
                          removeBottom: true,
                          child: ListView(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow:  [
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                "Qty:",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Type",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                            "10",
                                            style: GoogleFonts.poppins(
                                              color: AppColors.thirdColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              height: 1.2
                                            ),
                                          ),
                                          Icon(
                                            Icons.edit_outlined,
                                            color: AppColors.secondColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    
                  ],
                ),
              )
            ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: OpenContainer(
                transitionDuration:const Duration(milliseconds: 500),
                transitionType: ContainerTransitionType.fade,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return  AddStock(
                    // itemType: widget.itemType,
                  );
                },
                closedElevation: 6.0,
                closedShape: const  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                closedColor:  AppColors.mainColor,
                closedBuilder: (BuildContext context, VoidCallback openContainer) {
                  return Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: AppColors.mainColor,
                      shape: BoxShape.circle,
                      boxShadow:  [
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
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              // child: Container(
              //   height: 70,
              //   width: 70,
              //   decoration: const BoxDecoration(
              //     color: AppColors.mainColor,
              //     shape: BoxShape.circle,
              //     boxShadow:  [
              //       BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15)),
              //       BoxShadow(
              //         color: Color.fromRGBO(0, 0, 0, 0.15),
              //         blurRadius: 11.0,
              //         spreadRadius: 0.0,
              //         offset: Offset(
              //           0.0,
              //           3.0,
              //         ),
              //       )
              //     ],
              //   ),
              //   child: const Center(
              //     child: Icon(
              //       Icons.add,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            )
          ),
        )
      ],
    );
  }
}
