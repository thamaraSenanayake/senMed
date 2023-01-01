import 'package:animations/animations.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/model/stockModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widget/dropDown.dart';
import '../../widget/stockWidget.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late String _selectedStockItem;
  List<StockModel> _stockList = [];
  List<StockModel> _allStockList = [];
  String _search= "";

  @override
  void initState() {
    super.initState();
    _selectedStockItem = AppData.stockList[0];
    WidgetsBinding.instance.addPostFrameCallback((_){
      _initSate();
    });
  }

  _initSate() async {
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _allStockList = await Provider.of<FirebaseProvider>(context,listen: false).getStockList(_selectedStockItem,""); 
    
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    setState(() {
      _stockList = _allStockList;
    });
  }

  _sortList(){
    List<StockModel> _stockListTemp = [];
    _stockListTemp.addAll(_allStockList);
    if(_selectedStockItem == AppData.stockList[1]){
      _stockListTemp.removeWhere((element) => element.stockType == AppData.stockList[2]);
    }
    else if(_selectedStockItem == AppData.stockList[2]){
      _stockListTemp.removeWhere((element) => element.stockType == AppData.stockList[1]);
    }

    if(_search.isNotEmpty){
      _stockListTemp.removeWhere((element) => !element.name.contains(_search));
    }
    setState(() {
      _stockList = _stockListTemp;
    });
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
                        _sortList();
                      },

                    ),
                    CustomTextBox(
                      onChange: (val){
                        _search = val;
                        _sortList();
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
                          child: ListView.builder(
                            itemCount: _stockList.length,
                            itemBuilder: (BuildContext context, int index) => StockWidget(
                              stock: _stockList[index],
                              edit: () async {
                                await Get.to( AddStock(stockModel: _stockList[index]));
                                _initSate();
                              },
                            )
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
                   return   AddStock(
                    // itemType: widget.itemType,
                  );
                },
                closedElevation: 6.0,
                closedShape: const  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                onClosed: (val){
                  _initSate();
                },
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
            )
          ),
        ),

        Loader(),
      ],
    );
  }
}
