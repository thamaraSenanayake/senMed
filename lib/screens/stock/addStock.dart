import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

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

  bool _isAdditionalQtyDisplay = false;
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

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isAdditionalQtyDisplay = true;
                                    _isAdditionalPlus = false;
                                  });
                                  _additonalQtyFocus.requestFocus();
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
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
                                  child: const Icon(
                                    Icons.remove,
                                    color: AppColors.thirdColor,
                                  ),
                                ),
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
                                width: _size.width - 150,
                                textBoxHint: "Qty",
                                textInputType: TextInputType.number,
                                onSubmit: (val) {
                                  _sellingPriceFocus.requestFocus();
                                },
                              ),

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isAdditionalQtyDisplay = true;
                                    _isAdditionalPlus = true;
                                  });
                                  _additonalQtyFocus.requestFocus();
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
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
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.thirdColor,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          if(_isAdditionalQtyDisplay)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const SizedBox(
                                width: 48,                                
                              ),

                              SizedBox(
                                width: 48,  
                                height: 48,
                                child: Center(
                                  child: Container(
                                    width: 30,  
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 2
                                      ),
                                      shape: BoxShape.circle
                                    ),
                                    child:  Icon(
                                      _isAdditionalPlus? Icons.add:Icons.remove,
                                      color: AppColors.mainColor,
                                    ),                              
                                  ),
                                ),
                              ),

                              CustomTextBox(
                                focusNode: _additonalQtyFocus,
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
                                width: _size.width - 204,
                                textBoxHint: _isAdditionalPlus? "Add to Qty":"Subtract from Qty",
                                textInputType: TextInputType.number,
                                onSubmit: (val) {
                                  _sellingPriceFocus.requestFocus();
                                },
                              ),

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isAdditionalQtyDisplay = false;
                                  });
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
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
                                  child: const Icon(
                                    Icons.done,
                                    color: AppColors.thirdColor,
                                  ),
                                ),
                              ),

                            ],
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
                              _sellingPriceController.text= _sellingPrice.toStringAsFixed(2);
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
                                ),),
                            errorText: _sellingPriceError,
                            width: _size.width - 40,
                            textBoxHint: "Selling Price",
                            textEditingController: _sellingPriceController,
                            textInputType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomDropDown(value: _selectedType, valueList: AppData.stockList, onChange: (val){}),
                          ),
                          CustomTextBox(
                            focusNode: _waringQtyFocus,
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
                            textBoxHint: "Waring Qty Limit",
                            onSubmit: (val) {
                              // _qtyFocus.requestFocus();
                            },
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
