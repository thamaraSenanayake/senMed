import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../const.dart';
import '../providers/base_provider.dart';
import '../providers/firebase_provider.dart';
import '../res.dart';
import '../widget/loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Consumer<FirebaseProvider>(
      builder: (context, value, child) {
       return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          body: Stack(
            children: [

              SizedBox(
                height: _size.height,
                width: _size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children:[
                      SizedBox(
                        height: _size.height,
                        width: _size.width,
                        child: Image.asset(
                          "assets/image/background.png",
                          fit: BoxFit.cover,
                          color: Colors.white.withOpacity(0.4),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      )
                    ]
                  ),
                ),
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.center,
                  child:Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Container(
                      height: 250,
                      // color: Colors.amber,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // width: 200,
                        children:[ 
                            Padding(
                             padding: const EdgeInsets.only(right: 20),
                             child: Image.asset(
                              "assets/image/logo.png"
                            ),
                          ),

                        ]
                      ),
                    ),
                  ),
                ),
              ),
              
              
              Loader(),
            ],
          ),
        );
      }
    );
  }
}