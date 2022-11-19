import 'dart:io';

import 'package:balance/model/stockModel.dart';
import 'package:balance/providers/firebase_provider.dart';
import 'package:balance/widget/dateTimePicker.dart';
import 'package:balance/widget/textbox.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../widget/button.dart';
import '../widget/header.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  String _name="";
  String _school = '';

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("Add Stock")),
      body: SafeArea(
        child: SizedBox(
          width: _size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Header(
                  title: "Add Stock",
                  leftClick: (){

                  },
                  leftIcon: Icons.arrow_back_ios_new,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextBox(
                  onChange: (val){
                    _name = val;
                  }, 
                  errorText: "", 
                  width: _size.width-40,
                  leftIcon: Icons.text_fields,
                  textBoxHint: "Name",
                ),
                
                CustomTextBox(
                  onChange: (val){
                    _school = val;
                  }, 
                  errorText: "", 
                  width: _size.width-40,
                  leftIcon: Icons.numbers,
                  textBoxHint: "Quantity",
                  textInputType: TextInputType.number,
                ),

                DateTimePickerView(onChange: (val){}, textBoxHint: "Expire Date", width: _size.width-40, errorText: ""),
                
                CustomTextBox(
                  onChange: (val){
                    _school = val;
                  }, 
                  errorText: "", 
                  width: _size.width-40,
                  leftIcon: Icons.money,
                  textBoxHint: "Buying Price",
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                ),

                CustomTextBox(
                  onChange: (val){
                    _school = val;
                  }, 
                  errorText: "", 
                  width: _size.width-40,
                  leftIcon: Icons.money,
                  textBoxHint: "Sell Price",
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                ),

                
                
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top:50),
                  child: CustomButton(
                    title: "Add", 
                    onPress: (){
                      // _logIn(value);
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}