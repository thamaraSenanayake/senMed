import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppColors {
  static const Color mainColor = Color(0xff06283D);
  static const Color secondColor = Color(0xff1363DF);
  static const Color thirdColor = Color(0xff47B5FF);
  // static const Color backGroundColor = Color(0xffF5F5F5);
  static const Color backGroundColor = Color(0xffDFF6FF);
  static const List<BoxShadow> shadow = [
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
  ];
}

DateTime? getFirebaseTime(val) {
  Timestamp? timestamp = val;
  DateTime? dateTime;
  if (val == null) {
    return null;
  }
  if (timestamp != null) {
    dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }
  return dateTime!;
}

Future<File?> getImage(bool isCamera, BuildContext context) async {
  XFile? image;
  final picker = ImagePicker();

  if (isCamera) {
    image = await picker.pickImage(source: ImageSource.camera);
  } else {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}

Future<void> selectDate(BuildContext context, DateTime _dateTime, Function(DateTime) setDateTime) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _dateTime,
    firstDate: DateTime(1948, 8),
    lastDate: DateTime(DateTime.now().year + 1),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.secondColor,
            onPrimary: Colors.black,
            surface: AppColors.mainColor,
            onSurface: AppColors.secondColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
  if (picked != null && picked != _dateTime) {
    setDateTime(picked);
  }
}

Future<void> timePicker(BuildContext context, TimeOfDay _timeOfDay,Function(TimeOfDay) setTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: _timeOfDay,
    initialEntryMode: TimePickerEntryMode.dialOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.secondColor,
            onPrimary: Colors.black,
            surface: AppColors.mainColor,
            onSurface: AppColors.secondColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
  if (picked != null ) {
    setTime(picked);
  }
}
