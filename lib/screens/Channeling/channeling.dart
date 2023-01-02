import 'package:animations/animations.dart';
import 'package:balance/model/channelingModel.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/channelWidget.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import 'addChanneling.dart';

class ChannelingList extends StatefulWidget {
  const ChannelingList({Key? key}) : super(key: key);

  @override
  State<ChannelingList> createState() => _ChannelingListState();
}

class _ChannelingListState extends State<ChannelingList> {
  List<ChannelingModel> _channelingList = [];

  @override
  void initState() {
    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_){
      _loadData(); 
    });
  }

  _loadData() async {
    
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _channelingList = await Provider.of<FirebaseProvider>(context,listen: false).getChannelingList(); 
   
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
            padding: EdgeInsets.all(20),
            child:MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: _channelingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ChannelWidget(
                            model: _channelingList[index],
                            onClick: (){
                              Provider.of<BaseProvider>(context,listen: false).setProfilePage(Pages.ChannelingDetails,channelingModel:_channelingList[index] );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                  return  AddChanneling(
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
            )
          ),
        ),

        Loader()
      ],
    );
  }
}
