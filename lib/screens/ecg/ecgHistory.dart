import 'package:animations/animations.dart';
import 'package:balance/const.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/providers/firebase_provider.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/ecgHistoryWidget.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/base_provider.dart';

class ECGHistory extends StatefulWidget {
  const ECGHistory({Key? key}) : super(key: key);

  @override
  State<ECGHistory> createState() => _EcgHisECGHistoryState();
}

class _EcgHisECGHistoryState extends State<ECGHistory> {
  DateTime? _initDateTime;
  List<ECGModel> _ecgList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadData(); 
    });
  }

  _loadData() async {
    
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _ecgList = await Provider.of<FirebaseProvider>(context,listen: false).getECGList(); 
    if(_ecgList.isNotEmpty){
      _initDateTime = _ecgList[0].dateTime;
    }
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    setState(() {
      
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
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: MediaQuery.removePadding(
              context: context, 
              child: ListView.builder(
                itemCount: _ecgList.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime newDate  =DateTime(_ecgList[index].dateTime.year,_ecgList[index].dateTime.month,_ecgList[index].dateTime.day);
                  if(index == 0 || _initDateTime != newDate){
                    _initDateTime = newDate;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            DateFormat('EEE, MMM d,').format(_initDateTime!),
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ECGHistoryWidget(onClick: (){}, ecgModel: _ecgList[index]),
                      ],
                    );
                  }
                  return ECGHistoryWidget(onClick: (){}, ecgModel: _ecgList[index]);
                } 
              ),
            ),
          ),
        ),
        Loader()
      ],
    );
  }
}
