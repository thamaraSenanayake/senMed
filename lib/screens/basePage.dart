import 'package:balance/screens/Channeling/channeling.dart';
import 'package:balance/screens/Channeling/channlingDetails.dart';
import 'package:balance/screens/ecg/ecgHistory.dart';
import 'package:balance/screens/ecg/ecgScreen.dart';
import 'package:balance/screens/otherExpends/extraItemList.dart';
import 'package:balance/screens/privatePractice.dart';
import 'package:balance/screens/settings.dart';
import 'package:balance/screens/stock/stockScreen.dart';
import 'package:balance/screens/vistiingDoctors/doctorScreen.dart';
import 'package:balance/widget/otherExpendsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../providers/base_provider.dart';
import '../res.dart';
import '../widget/drawer.dart';
import '../widget/header.dart';
import 'ExtraItems/extraItemList.dart';
import 'addDefultValues.dart';
import 'homScreen.dart';
import 'vistiingDoctors/addDoctor.dart';


class BasePage extends StatelessWidget {
  BasePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Pages currentPage = Provider.of<BaseProvider>(context).currentPage;
    
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
              children: appDrawerContent(_scaffoldKey,context),
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
                  currentPage == Pages.Channeling?
                  const ChannelingList():
                  currentPage == Pages.ChannelingDetails?
                  const ChannelingDetails():
                  currentPage == Pages.Settings?
                  const SettingsScreen():
                  currentPage == Pages.VisitingDoctors?
                  const DoctorScreen():
                  currentPage == Pages.DefaultValues?
                  const AddDefault():
                  currentPage == Pages.ChannelingExtraItems?
                  const ExtraItemList():
                  currentPage == Pages.OtherExpends?
                  const OtherExpendsList():
                  currentPage == Pages.ECGHistory?
                  const ECGHistory():
                  
                  
                  Container(),
                ),
              ),
            ),
            SafeArea(
              child: Header(
                title: _setPageTitle(currentPage),
                leftClick: (){
                  if(currentPage == Pages.HomePage){
                    _scaffoldKey.currentState!.openDrawer();
                  }
                  else if(currentPage == Pages.ECGHistory){
                    Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.ECG);
                  }
                  else if(currentPage == Pages.VisitingDoctors || currentPage == Pages.DefaultValues){
                    Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Settings);
                  }
                  else if(currentPage == Pages.ChannelingDetails){
                    Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Channeling);
                  }else{
                    Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.HomePage);
                  }
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
    else if(currentPage == Pages.ECGHistory){
      return "ECG History";
    }
    else if(currentPage == Pages.Stock){
      return "Stock";
    }
    else if(currentPage == Pages.PrivatePractice){
      return "Private Practice";
    }
    else if(currentPage == Pages.Channeling){
      return "Channeling";
    }
    else if(currentPage == Pages.ChannelingDetails){
      return "Doctors Name";
    }
    else if(currentPage == Pages.Settings){
      return "Settings";
    }
    else if(currentPage == Pages.VisitingDoctors){
      return "Visiting Doctors";
    }
    else if(currentPage == Pages.DefaultValues){
      return "Default Values";
    }
    else if(currentPage == Pages.ChannelingExtraItems){
      return "Channeling Features";
    }
    else if(currentPage == Pages.OtherExpends){
      return "Other Expends";
    }
    return "";
  }

  String? _setRightButton(Pages currentPage){
    if(currentPage == Pages.ECG){
      return "History";
    }
    if(currentPage == Pages.PrivatePractice){
      return "History";
    }
    if(currentPage == Pages.ChannelingDetails){
      return "Done";
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