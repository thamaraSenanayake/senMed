import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/res.dart';
import 'package:balance/screens/stock/addStock.dart';
import 'package:balance/widget/button.dart';
import 'package:balance/widget/header.dart';
import 'package:balance/widget/textbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class ECGScreen extends StatefulWidget {
  const ECGScreen({Key? key}) : super(key: key);

  @override
  State<ECGScreen> createState() => _EcgScreenState();
}

class _EcgScreenState extends State<ECGScreen> {
  String _id="";
  String _name="";
  String _age="";
  late int _amount;
  DateTime? _dateTime;
  String _idError = "";
  String _nameError = "";
  String _ageError = "";
  String _amountError = "";
  String _dateTimeError = "";
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _amount = 300;
    WidgetsBinding.instance.addPostFrameCallback((_){
      _nameFocus.requestFocus();
    });
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
            child: SingleChildScrollView(
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
                      CustomTextBox(
                        focusNode: _nameFocus,
                        onChange: (val){
                          _name = val;
                          if(_nameError.isNotEmpty){
                            setState(() {
                              _nameError = "";
                            });
                          }
                        }, 
                        errorText: _nameError,
                        width: _size.width-40,
                        textBoxHint: "Name",
                        onSubmit: (val){
                          _ageFocus.requestFocus();
                        },
                      ),
                      CustomTextBox(
                        focusNode: _ageFocus,
                        onChange: (val){
                          _age = val;
                          if(_ageError.isNotEmpty){
                            setState(() {
                              _ageError = "";
                            });
                          }
                        }, 
                        errorText: _ageError,
                        width: _size.width-40,
                        textBoxHint: "Age",
                        textInputType: TextInputType.number,
                        onSubmit: (val){
                          _amountFocus.requestFocus();
                        },
                      ),
                      CustomTextBox(
                        focusNode: _amountFocus,
                        onChange: (val){
                          if(int.tryParse(val) != null){
                            _amount = int.parse(val);
                            if(_amountError.isNotEmpty){
                              setState(() {
                                _amountError = "";
                              });
                            }
                          }else{
                            _amount = 0;
                          }
                        }, 
                        onEditingComplete: (){
                          _controller.text= _amount.toStringAsFixed(2);
                        },
                        leftIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            "LKR",
                            style: GoogleFonts.poppins(
                              fontSize:13, 
                              color: Colors.black, 
                              fontWeight: FontWeight.w500,
                              // height: 1.5
                            ),
                          )
                        ),
                        errorText: _amountError,
                        width: _size.width-40,
                        textBoxHint: "Amount",
                        initText: _amount.toStringAsFixed(2),
                        textEditingController: _controller,
                        textInputType: const TextInputType.numberWithOptions(decimal: true),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CustomButton(title: "Done", onPress: (){}),
                      )
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
