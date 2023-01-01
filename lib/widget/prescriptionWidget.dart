import 'package:balance/model/prescription.dart';
import 'package:balance/model/stockModel.dart';
import 'package:balance/providers/firebase_provider.dart';
import 'package:balance/res.dart';
import 'package:balance/widget/dropDown.dart';
import 'package:balance/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class PrescriptionWidget extends StatefulWidget {
  final Prescription prescription;
  final bool addDisplay;
  final Function addNew;
  final Function onChange;
  final List<String> medicineList;
  const PrescriptionWidget({Key? key, required this.prescription, required this.addDisplay, required this.addNew, required this.medicineList, required this.onChange})
      : super(key: key);

  @override
  State<PrescriptionWidget> createState() => _PrescriptionWidgetState();
}

class _PrescriptionWidgetState extends State<PrescriptionWidget> {
  final TextEditingController _nameController = TextEditingController();
  String _nameError = "";
  String _daysError = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            height: 50,
            width: size.width - 40,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
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
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TypeAheadField(
                hideOnLoading: true,
                hideOnEmpty: true,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xffB3A9A9),
                      height: 1.8,
                    ),
                  ),
                  onChanged: (value) {
                    widget.prescription.name = value;
                    if (_nameError.isNotEmpty) {
                      setState(() {
                        _nameError = "";
                      });
                    }
                    widget.onChange();
                  },
                  onSubmitted: (value) {},
                ),
                suggestionsCallback: (pattern) async {
                  if(pattern.isEmpty){
                    return [];
                  }
                  List<String> _stringList = []; 
                 
                  for (var element in widget.medicineList) {
                    if(element.startsWith(pattern.toLowerCase())){
                      _stringList.add(element);
                    }
                  }
                  for (var element in widget.medicineList) {
                    if((!_stringList.contains(element)) && element.contains(pattern.toLowerCase())){
                      _stringList.add(element);
                    }
                  }
                  
                  return _stringList;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  widget.prescription.name = suggestion.toString();
                  _nameController.text = suggestion.toString();
                  widget.onChange();
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomDropDown(
                width: (size.width-120)/2,
                value: widget.prescription.does,
                valueList: AppData.dose,
                onChange: (val) {
                  widget.prescription.does =val;
                  widget.onChange();
                },
              ),

              CustomTextBox(
                onChange: (val){
                  if(int.tryParse( val) != null){
                    widget.prescription.days = int.parse(val);
                    if(_daysError.isNotEmpty){
                      setState(() {
                        _daysError = "";
                      });
                    }
                    widget.onChange();
                  }
                },
                textBoxHint: "Days",
                textInputType: TextInputType.number,
                errorText: _daysError, 
                width: (size.width-120)/2,
              ),

              if(widget.addDisplay)
              GestureDetector(
                onTap: (){
                  widget.addNew();
                },
                child: Container(
                  decoration:const BoxDecoration(
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
                  height: 45,
                  width: 45,
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.thirdColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
