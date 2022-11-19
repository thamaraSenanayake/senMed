import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppColors{
  static const Color mainColor = Color(0xff06283D);
  static const Color secondColor = Color(0xff1363DF);
  static const Color thirdColor = Color(0xff47B5FF);
  // static const Color backGroundColor = Color(0xffF5F5F5);
  static const Color backGroundColor = Color(0xffDFF6FF);
}

DateTime? getFirebaseTime(val){
  Timestamp? timestamp = val;
  DateTime? dateTime;
  if(val == null){
    return null;
  }
  if(timestamp !=null){
    dateTime =DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }
  return dateTime!;
}

Future<File?> getImage(bool isCamera,BuildContext context) async{
    XFile? image;
    final picker = ImagePicker();

    if (isCamera) {
      
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      
        image = await picker.pickImage(source: ImageSource.gallery);
      
    }

    if(image != null){
      return File(image.path);
    }else{
      return null;
    }
  } 