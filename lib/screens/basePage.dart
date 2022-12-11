import 'package:balance/screens/ecgScreen.dart';
import 'package:balance/screens/privatePractice.dart';
import 'package:balance/screens/stockScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../providers/base_provider.dart';
import '../res.dart';
import '../widget/header.dart';
import 'homScreen.dart';


class BasePage extends StatelessWidget {
  BasePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Pages currentPage = Provider.of<BaseProvider>(context).currentPage;
    // final Widget? reportWidget = Provider.of<BaseProvider>(context).reportWidget;
    // final String pageTitle = Provider.of<BaseProvider>(context).pageTitle;
    // final ButtonClick? bottomBarButton = Provider.of<BaseProvider>(context).click;
    return WillPopScope(
      onWillPop: ()async => await _backClick(currentPage,context,isAndroidBackButton: true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: Drawer(
            elevation: 50,
            child: ListView(
              // children: appDrawerContent(_scaffoldKey,context),
            ),
          ),
        ),
        body: Stack(
          children: [
             Container(
              height: 100,
              color: AppColors.mainColor,
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  color: const Color(0xffEFF2F4),
                  child: currentPage == Pages.HomePage?
                  const HomeScreen():
                  currentPage == Pages.ECG?
                  const ECGScreen():
                  currentPage == Pages.Stock?
                  const StockScreen():
                  currentPage == Pages.PrivatePractice?
                  const PrivatePractice():
                  
                  
                  Container(),
                ),
              ),
            ),
            SafeArea(
              child: Header(
                title: _setPageTitle(currentPage),
                leftClick: (){
                  Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.HomePage);
                },
                leftIcon: _setLeftIcon(currentPage),
                rightIconText:_setRightButton(currentPage),
                rightClick: (){
                  if(currentPage == Pages.ECG){
                    Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.ECGHistory);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

  }

  _backClick(Pages currentPage,BuildContext context,{bool isAndroidBackButton=false}) async {

    if(currentPage == Pages.ECG){

    }
    
  }

  String _setPageTitle(Pages currentPage){
    if(currentPage == Pages.HomePage){
      return "Menu";
    }
    else if(currentPage == Pages.ECG){
      return "ECG";
    }
    else if(currentPage == Pages.Stock){
      return "Stock";
    }
    else if(currentPage == Pages.PrivatePractice){
      return "Private Practice";
    }
    return "";
  }

  String? _setRightButton(Pages currentPage){
    if(currentPage == Pages.ECG){
      return "History";
    }
    return "";
  }

  IconData? _setLeftIcon(Pages currentPage){
    if(currentPage != Pages.HomePage){
      return Icons.arrow_back;
    }
    else{
      return Icons.menu;
    }
  }

  

  
}