import 'package:balance/model/stockModel.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/textbox.dart';
import 'package:balance/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/base_provider.dart';
import '../../providers/firebase_provider.dart';
import '../../res.dart';
import '../../widget/button.dart';
import '../../widget/header.dart';

class AddStock extends StatefulWidget {
  final StockModel? stockModel;
  const AddStock({Key? key, this.stockModel}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  String _name = "";
  String _nameError = "";
  int _qty = 0;
  int _additionalQty = 0;
  String _additionalQtyError = "";
  String _qtyError = "";
  double _sellingPrice =0;
  String _sellingPriceError = "";
  String _selectedType = "";
  String _selectedTypeError = "";
  int _waringQtyLimit = 0;
  String _waringQtyLimitError = "";
  List<String> _stringList = [];
  
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _qtyFocus = FocusNode();
  final FocusNode _additionalQtyFocus = FocusNode();
  final FocusNode _sellingPriceFocus = FocusNode();
  final FocusNode _waringQtyFocus = FocusNode();

  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  bool _isAdditionalQtyDisplay = false;
  bool _isAdditionalPlus = true;

  @override
  void initState() {
    super.initState();
    if(widget.stockModel == null){
      _selectedType = AppData.stockList[1];
    }else{
      _name = widget.stockModel!.name;
      _selectedType= widget.stockModel!.stockType;
      _qty= widget.stockModel!.qty;
      _sellingPrice= widget.stockModel!.sellPrice;
      _waringQtyLimit= widget.stockModel!.waringQtyLimit;
    }
    for (var element in AppData.stockList) {
      if(element != AppData.stockList[0]){
        _stringList.add(element);
      }
    }
  }

  _done() async {
    bool _validation = true;
    if(_name == ""){
      setState(() {
        _nameError ="Required Field";
      });
      _validation = false;
    }
    if(_qty == 0){
      setState(() {
        _qtyError ="Required Field";
      });
      _validation = false;
    }
    if(_sellingPrice ==0){
      setState(() {
        _sellingPriceError = "Required Field";
      });
      _validation = false;
    }
    if(_selectedType == ""){
      setState(() {
        _selectedTypeError ="Required Field";
      });
      _validation = false;
    }
    if(_waringQtyLimit == 0){
      setState(() {
        _waringQtyLimitError ="Required Field";
      });
      _validation = false;
    }
    if(_validation){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      if(widget.stockModel == null){
        if( await Provider.of<FirebaseProvider>(context,listen: false).addStockData(StockModel(  name: _name, qty: _qty, sellPrice: _sellingPrice, stockType: _selectedType,waringQtyLimit: _waringQtyLimit))){
          Get.back();
        }
      }else{
        if( await Provider.of<FirebaseProvider>(context,listen: false).updateStockData(StockModel(id: widget.stockModel!.id,  name: _name, qty: _qty, sellPrice: _sellingPrice, stockType: _selectedType,waringQtyLimit: _waringQtyLimit))){
          Get.back();
        }

      }
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    }
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
                            initText: _name,
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
                                  _additionalQtyFocus.requestFocus();
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
                                initText: _qty.toString(),
                                focusNode: _qtyFocus,
                                textEditingController: _qtyController,
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
                                  _additionalQtyFocus.requestFocus();
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
                                focusNode: _additionalQtyFocus,
                                onChange: (val) {
                                  if(int.tryParse(val) != null){
                                    _additionalQty = int.parse(val);
                                    if (_additionalQtyError.isNotEmpty) {
                                      setState(() {
                                        _additionalQtyError = "";
                                      });
                                    }
                                  }else{
                                    _additionalQty = 0;
                                  }
                                },
                                errorText: _additionalQtyError,
                                width: _size.width - 204,
                                textBoxHint: _isAdditionalPlus? "Add to Qty":"Subtract from Qty",
                                textInputType: TextInputType.number,
                                onSubmit: (val) {
                                  _sellingPriceFocus.requestFocus();
                                },
                              ),

                              GestureDetector(
                                onTap: (){

                                  if(_isAdditionalPlus){
                                    _qty = _additionalQty + _qty;
                                    _qtyController.text = _qty.toString();
                                    setState(() {
                                      _isAdditionalQtyDisplay = false;
                                    });
                                  }
                                  else {
                                    if(_additionalQty>_qty){
                                      setState(() {
                                        _additionalQtyError = "Required Field";
                                      });
                                    }else{
                                      _qty = _qty - _additionalQty;
                                      _qtyController.text = _qty.toString();
                                      setState(() {
                                        _isAdditionalQtyDisplay = false;
                                      });
                                    }
                                  }
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
                            initText: _sellingPrice.toStringAsFixed(2),
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
                            child: CustomDropDown(value: _selectedType, valueList: _stringList , onChange: (val){_selectedType=val;}),
                          ),
                          CustomTextBox(
                            initText: _waringQtyLimit.toString(),
                            focusNode: _waringQtyFocus,
                            onChange: (val) {
                              if (int.tryParse(val) != null) {
                                _waringQtyLimit = int.parse(val);
                                if (_waringQtyLimitError.isNotEmpty) {
                                  setState(() {
                                    _waringQtyLimitError = "";
                                  });
                                }
                              } else {
                                _waringQtyLimit = 0;
                              }
                            },
                            errorText: _waringQtyLimitError,
                            width: _size.width - 40,
                            textBoxHint: "Waring Qty Limit",
                            onSubmit: (val) {
                              // _qtyFocus.requestFocus();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CustomButton(title: "Done", onPress: () {_done();}),
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
          ),
          Loader(),
        ],
      ),
    );
  }
}
