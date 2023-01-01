import 'package:balance/model/ppModel.dart';
import 'package:balance/model/prescription.dart';
import 'package:balance/model/stockModel.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/loader.dart';
import 'package:balance/widget/prescriptionWidget.dart';
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
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
class PrivatePractice extends StatefulWidget {
  const PrivatePractice({Key? key}) : super(key: key);

  @override
  State<PrivatePractice> createState() => _PrivatePracticeState();
}

class _PrivatePracticeState extends State<PrivatePractice> {
  String _name = "";
  String _nameError = "";
  String _age = "";
  String _ageError = "";
  bool _isMale = true;
  bool _isExtraView = false;
  String _prescriptionListError = "";
  List<String> _medicineList = [];
  List<Prescription> _prescriptionList = [Prescription(days: 0, does: AppData.dose[0], name: '')];
  int _bP =0;
  final TextEditingController _bPController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int _dressing =0;
  final TextEditingController _dressingController = TextEditingController();
  int _other =0;
  final TextEditingController _otherController = TextEditingController();
  int _doctorsCharge =0;
  final TextEditingController _doctorsChargeController = TextEditingController();
  int _medicineCharge =0;
  int _totalCost =0;
  List<StockModel> _stockList =[];
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool _displayPadding = false;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadMedicine();
    });
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        setState(() {
          _displayPadding = !visible;
        });
      }
    });
    super.initState();
  }
  
  _loadMedicine() async {
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
    _stockList = await Provider.of<FirebaseProvider>(context,listen: false).getStockList(AppData.stockList[1], "");
    for (var element in _stockList) {
      _medicineList.add(element.name);
    }
    Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
  }

  _totalCostDisplay(){
    _totalCost = _bP +_dressing +_other +_doctorsCharge + _medicineCharge;
    setState(() {
      
    });
  }

  _prescriptionOnChange(){
    int _medicineChargeTemp = 0;
    for (var element in _prescriptionList) {
      int _qty =0;
      int _multipleBy = AppData.getDoseMultiply(element.does);
      _qty =  (_multipleBy*element.days);
      StockModel? _stockItem = _stockList.firstWhereOrNull((e) => e.name == element.name);
      if(_stockItem != null){
        _medicineChargeTemp += (_qty*_stockItem.sellPrice.round());
      }
    }
    if(_medicineCharge != _medicineChargeTemp){
      setState(() {
        _medicineCharge = _medicineChargeTemp;
      });
      _totalCostDisplay();
    }
  }

  _done() async {
    bool _validation = true;

    if(_name.isEmpty){
      setState(() {
        _nameError = "Required field";
      });
      _validation = false;
    }
    if(_age.isEmpty){
      setState(() {
         _ageError = "Required field";
      });
      _validation = false;
    }


    if(_validation){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      if(_prescriptionList.last.name.isEmpty){
        _prescriptionList.removeLast();
      }
      if( await Provider.of<FirebaseProvider>(context,listen: false).addPPData(PPModel(medicineCharge: _medicineCharge, bp: _bP, dressing: _dressing, otherExpends: _other, doctorsCharge: _doctorsCharge,  dateTime: DateTime.now(), name: _name, age: _age, prescriptionList: _prescriptionList))){
        _bPController.text = "";
        _nameController.text = "";
        _ageController.text = "";
        _dressingController.text = "";
        _otherController.text = "";
        _doctorsChargeController.text = "";
        _totalCost =0;
        _prescriptionList = _prescriptionList = [Prescription(days: 0, does: AppData.dose[0], name: '')];
        setState(() {
          
        });
      }
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    }
    
  }

  _addPrescription(){
    if(_prescriptionList.last.name.isEmpty || _prescriptionList.last.days==0 ){
      setState(() {
        _prescriptionListError = "Required Fields are missing";
      });
    }else{
      _prescriptionList.add(Prescription(days: 0, does: AppData.dose[0], name: ''));
      _prescriptionListError ="";
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            textEditingController: _nameController,
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
                              _ageFocus.requestFocus();
                            },
                            textInputType: TextInputType.name,
                          ),
                          CustomTextBox(
                            textEditingController: _ageController,
                            focusNode: _ageFocus,
                            onChange: (val) {
                              _age = val;
                              if (_ageError.isNotEmpty) {
                                setState(() {
                                  _ageError = "";
                                });
                              }
                            },
                            errorText: _ageError,
                            width: _size.width - 40,
                            textBoxHint: "Age",
                            onSubmit: (val) {},
                            textInputType: TextInputType.number,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _isMale = !_isMale;
                                    });
                                  },
                                  child:Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Male",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: _isMale?AppColors.mainColor:Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ) ,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _isMale = !_isMale;
                                    });
                                  },
                                  child:Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Female",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: !_isMale?AppColors.mainColor:Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ) ,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: _size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Prescription",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    _prescriptionListError,
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _prescriptionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PrescriptionWidget(
                                  onChange: _prescriptionOnChange,
                                  medicineList: _medicineList,
                                  prescription: _prescriptionList[index], 
                                  addDisplay: _prescriptionList.last == _prescriptionList[index], 
                                  addNew: (){
                                    _addPrescription();
                                  },
                                );
                              }
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30,),
                            child: SizedBox(
                              width: _size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Extra",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _isExtraView = !_isExtraView;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.mainColor
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Icon(
                                          _isExtraView ?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
                                          color: AppColors.thirdColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          if(_isExtraView)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Text(
                                  "Blood Pressure",
                                  style: GoogleFonts.poppins(
                                    fontSize:13, 
                                    color: Colors.black, 
                                    fontWeight: FontWeight.w500,
                                    // height: 1.5
                                  ),
                                ),
                                CustomTextBox(
                                  onChange: (val){
                                    if(int.tryParse(val) != null){
                                      _bP= int.parse(val);
                                    }else{
                                      _bP= 0;
                                    }
                                  }, 
                                  onEditingComplete: (){
                                    _bPController.text= _bP.toStringAsFixed(2);
                                    _totalCostDisplay();
                                    
                                  }, 
                                  textEditingController: _bPController,
                                  topPadding: false,
                                  errorText: "", 
                                  textBoxHint: "BP",
                                  width: _size.width - 40,
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
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
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  "Dressing",
                                  style: GoogleFonts.poppins(
                                    fontSize:13, 
                                    color: Colors.black, 
                                    fontWeight: FontWeight.w500,
                                    // height: 1.5
                                  ),
                                ),
                                CustomTextBox(
                                  onChange: (val){
                                    if(int.tryParse(val) != null){
                                      _dressing= int.parse(val);
                                    }else{
                                      _dressing= 0;
                                    }
                                  }, 
                                  onEditingComplete: (){
                                    _dressingController.text= _dressing.toStringAsFixed(2);
                                    _totalCostDisplay();
                                  }, 
                                  textEditingController:_dressingController,
                                  topPadding: false,
                                  errorText: "", 
                                  textBoxHint: "Dressing",
                                  width: _size.width - 40,
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
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
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  "Other",
                                  style: GoogleFonts.poppins(
                                    fontSize:13, 
                                    color: Colors.black, 
                                    fontWeight: FontWeight.w500,
                                    // height: 1.5
                                  ),
                                ),
                                CustomTextBox(
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
                                  onChange: (val){
                                    if(int.tryParse(val) != null){
                                      _other= int.parse(val);
                                    }else{
                                      _other= 0;
                                    }
                                  }, 
                                  onEditingComplete: (){
                                    _otherController.text= _other.toStringAsFixed(2);
                                    _totalCostDisplay();
                                  },  
                                  textEditingController:_otherController,
                                  topPadding: false,
                                  errorText: "", 
                                  textBoxHint: "Other",
                                  width: _size.width - 40,
                                  textInputType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20,),
                          Text(
                            "Doctors Charge",
                            style: GoogleFonts.poppins(
                              fontSize:13, 
                              color: Colors.black, 
                              fontWeight: FontWeight.w500,
                              // height: 1.5
                            ),
                          ),

                          CustomTextBox(
                            onChange: (val){
                              if(int.tryParse(val) != null){
                                _doctorsCharge= int.parse(val);
                              }else{
                                _doctorsCharge= 0;
                              }
                            }, 
                            onEditingComplete: (){
                              _doctorsChargeController.text= _doctorsCharge.toStringAsFixed(2);
                              _totalCostDisplay();
                            },  
                            textEditingController: _doctorsChargeController,
                            topPadding: false,
                            errorText: "", 
                            textBoxHint: "Doctors Charge",
                            width: _size.width - 40,
                            textInputType: const TextInputType.numberWithOptions(decimal: true),
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
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30,),
                            child: SizedBox(
                              width: _size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total Cost",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "LKR: ${_totalCost.toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CustomButton(title: "Done", onPress: () {_done();}),
                          ),

                          if(!_displayPadding)
                          SizedBox(height: 500,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Loader()
        ],
      ),
    );
  }
}
