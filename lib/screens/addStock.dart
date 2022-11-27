import 'dart:io';

import 'package:balance/const.dart';
import 'package:balance/model/stockModel.dart';
import 'package:balance/providers/firebase_provider.dart';
import 'package:balance/widget/dateTimePicker.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../res.dart';
import '../widget/button.dart';
import '../widget/header.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  String _name = "";
  String _nameError = "";
  int _qty = 0;
  String _qtyError = "";
  double _sellingPrice =0;
  String _sellingPriceError = "";
  String _selectedType = "";
  String _selectedTypeError = "";
  int _waringQtyLimit = 0;
  String _waringQtyLimitError = "";
  
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();
  final FocusNode _additonalQtyFocus = FocusNode();
  final FocusNode _sellingPriceFocus = FocusNode();
  final FocusNode _waringQtyFocus = FocusNode();

  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _additonalQtyController = TextEditingController();

  bool _isAdditionalQtyDiplay = false;
  bool _isAdditionalPlus = true;

  @override
  void initState() {
    super.initState();
    _selectedType = AppData.stockList[0];
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("Add Stock")),
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
                            onChange: (val) {
                              _name = val;
                              if (_nameError.isNotEmpty) {
                                setState(() {
                                  _nameError = "";
                                });
                              }
                            },
                            errorText: _nameError,
                            width: _size.width - 40,
                            textBoxHint: "Name",
                            onSubmit: (val) {
                              _qtyFocus.requestFocus();
                            },
                          ),
                          CustomTextBox(
                            focusNode: _qtyFocus,
                            onChange: (val) {
                              if(int.tryParse(val) != null){
                                _qty = int.parse(val);
                                if (_qtyError.isNotEmpty) {
                                  setState(() {
                                    _qtyError = "";
                                  });
                                }
                              }else{
                                _qty = 0;
                              }
                            },
                            errorText: _qtyError,
                            width: _size.width - 40,
                            textBoxHint: "Qty",
                            textInputType: TextInputType.number,
                            onSubmit: (val) {
                              _sellingPriceFocus.requestFocus();
                            },
                          ),
                          CustomTextBox(
                            focusNode: _sellingPriceFocus,
                            onChange: (val) {
                              if (double.tryParse(val) != null) {
                                _sellingPrice = double.parse(val);
                                if (_sellingPriceError.isNotEmpty) {
                                  setState(() {
                                    _sellingPriceError = "";
                                  });
                                }
                              } else {
                                _sellingPrice = 0;
                              }
                            },
                            onEditingComplete: () {
                              // _controller.text= _amount.toStringAsFixed(2);
                            },
                            leftIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "LKR",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    // height: 1.5
                                  ),
                                )),
                            errorText: _sellingPriceError,
                            width: _size.width - 40,
                            textBoxHint: "Selling Price",
                            // textEditingController: _controller,
                            textInputType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomDropDown(value: _selectedType, valueList: AppData.stockList, onChange: (val){}),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CustomButton(title: "Done", onPress: () {}),
                          )
                        ],
                      ),
                    ),),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child:Header(
                title: "Add Stock",
                leftClick: (){
                  Get.back();
                },
                leftIcon:Icons.arrow_back,
                
              ),
          )
        ],
      ),
    );
  }
}
