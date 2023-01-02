import 'package:animations/animations.dart';
import 'package:balance/model/extraItem.dart';
import 'package:balance/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../widget/extraItemWidget.dart';
import 'addExtraItem.dart';

class ExtraItemList extends StatefulWidget {
  const ExtraItemList({Key? key}) : super(key: key);

  @override
  State<ExtraItemList> createState() => _ExtraItemListState();
}

class _ExtraItemListState extends State<ExtraItemList> {
  List<ExtraItemModel> _extraItemList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadData(); 
    });
  }

  _loadData() async {
    
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _extraItemList = await Provider.of<FirebaseProvider>(context,listen: false).getExtraFeatherList(); 
    
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
            padding: const EdgeInsets.all(20),
            child:MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: _extraItemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: ExtraItemWidget(
                          extraItemModel:_extraItemList[index],
                          onClick: (){
                        
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // child: SingleChildScrollView(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: AnimationLimiter(
            //         child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: AnimationConfiguration.toStaggeredList(
            //         duration: const Duration(milliseconds: 375),
            //         childAnimationBuilder: (widget) => SlideAnimation(
            //           horizontalOffset: 50.0,
            //           child: FadeInAnimation(
            //             child: widget,
            //           ),
            //         ),
            //         children: [
            //           ExtraItemWidget(
            //             onClick: (){
                          
            //             },
            //           ),
            //         ],
            //       ),
            //     )),
            //   ),
            // ),
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
                  return  const AddExtraItem(
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
      ],
    );
  }
}
