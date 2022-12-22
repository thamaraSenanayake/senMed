import 'package:balance/res.dart';
import 'package:balance/widget/basePageElement.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../providers/base_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _initSate();
  }
  _initSate() async {

  }
  @override
  Widget build(BuildContext context) {
    Size _size  = MediaQuery.of(context).size;
    return  Stack(
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
                  child: Wrap(
                    runSpacing: 15,
                    spacing: 15,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment:WrapAlignment.spaceBetween ,
                    children: [
                      BasePageElement(image: "assets/image/ecg.png", title: "ECG", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.ECG);}),
                      
                      BasePageElement(image: "assets/image/salary.png", title: "Salary", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Salary);}),
                      
                      BasePageElement(image: "assets/image/stock.png", title: "Stock", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Stock);}),
                      
                      BasePageElement(image: "assets/image/income.png", title: "Income", onTap: (){}),
                      
                      BasePageElement(image: "assets/image/doctor.png", title: "Private Practice", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.PrivatePractice);} ),
                      
                      BasePageElement(image: "assets/image/stethoscope.png", title: "Channeling", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Channeling);}),
                      
                      BasePageElement(image: "assets/image/expend.png", title: "Other Expends", onTap: (){Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.Channeling);}),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }
}