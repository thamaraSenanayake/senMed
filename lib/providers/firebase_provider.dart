import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:balance/model/channelingModel.dart';
import 'package:balance/model/ecgModel.dart';
import 'package:balance/model/incomeModel.dart';
import 'package:balance/model/ppModel.dart';
import 'package:balance/model/stockModel.dart';
import 'package:balance/screens/basePage.dart';
import 'package:balance/screens/homScreen.dart';
import 'package:balance/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../model/patientModel.dart';
import '../res/platform_dialogue.dart';
// import 'base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_provider.dart';
// import 'package:get/get.dart';

class FirebaseProvider  extends BaseProvider {
  late FirebaseStorage firebaseStorage;
  late FirebaseAuth _auth;
  auth.User? _user;
  auth.User? get firebaseUser => _user;
  String? name;
  
  final CollectionReference ecgReference =  FirebaseFirestore.instance.collection('ecg');
  final CollectionReference ppReference =  FirebaseFirestore.instance.collection('pp');
  final CollectionReference channelingReference =  FirebaseFirestore.instance.collection('channeling');
  final CollectionReference stockReference =  FirebaseFirestore.instance.collection('stock');
  final CollectionReference incomeReference =  FirebaseFirestore.instance.collection('income');

  FirebaseProvider() {
    _auth = FirebaseAuth.instance;
    firebaseStorage = FirebaseStorage.instance;
    Timer(
      const Duration(seconds: 2),
      () async {
        _user = _auth.currentUser;
        if (_user == null) {
          Get.offAll(() => const Login());
        } else {
          // Get.offAll(() => const Login());
          // await getUserData(_user!);
          navigateToTabsPage(_user);
         
        }
      },
    );
  }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      // setLoadingState(true);
      final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = authResult.user;
      
      // setLoadingState(false);
      navigateToTabsPage(_user);
      
    } on SocketException catch (_) {
      return( "Network Connection Error");
    } on FirebaseAuthException catch (e) {
      // setLoadingState(false);
      if (e.code == "wrong-password") {
        return "Wrong Password";
      } else if (e.code == "user-not-found") {
        return "User Not Found";
        
      } else {
        return( e.code);
      }
    }
  }

   Future<String> updateImage(File file) async {
    String id = Uuid().v1();
    String filename = file.path.split("/").last;
    filename = id+filename;

    final storageReference = firebaseStorage.ref().child("groupImage").child(filename);
    await storageReference.putFile(file);
    final imageUrl = await FirebaseStorage.instance
        .ref(
          firebaseStorage.ref().child("groupImage").child(filename).fullPath,
        )
        .getDownloadURL();

    return imageUrl;
  }


  

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required List<double> latlon,
  }) async {
    try {
      // setLoadingState(true);
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = authResult.user;
      name = name;
      
      // setLoadingState(false);
      // Get.off(() => const HomeScreen());
    } on SocketException catch (_) {
      // setLoadingState(false);
      // showPlatformDialogue(title: "Network Connection Error");
    } on FirebaseAuthException catch (e) {
      // setLoadingState(false);
      if (e.code == "email-already-in-use") {
        // showPlatformDialogue(title: "Email Already In Use");
      } else {
        // showPlatformDialogue(title: e.code);
      }
    }
  }

  

  

  void navigateToTabsPage(auth.User? firebaseUser) {
    if (firebaseUser != null) {
      Get.offAll(() =>  BasePage());
    }
  }

  
  //add
  Future<bool> addEcgData(
    ECGModel ecgModel
  ) async {
    ecgModel.id =  Uuid().v4();
    ecgModel.incomeId =  Uuid().v4();
    try{
      await ecgReference.doc(ecgModel.id ).set(
        ecgModel.toMap(),
      );
    }catch(ex){
      return false;
    }
    await setIncome(true,ecgModel.amount/1, IncomeType.ecg, ecgModel.incomeId! );
    return true;
  }

  Future<bool> addPPData(
    PPModel ppModel
  ) async {
    ppModel.id =  Uuid().v4();
    ppModel.incomeId =  Uuid().v4();
    await ppReference.doc(ppModel.id ).set(
      ppModel.toMap(),
    );
    double cost =  (ppModel.dressing + ppModel.doctorsCharge+ppModel.medicineCharge+ppModel.otherExpends)/1;
    await setIncome(true,cost, IncomeType.pp, ppModel.incomeId!);
    return true;
  }
  Future<bool> addChannelData(
    ChannelingModel channelingModel
  ) async {
    channelingModel.id =  Uuid().v4();
    await channelingReference.doc(channelingModel.id ).set(
      channelingModel.toMap(),
    );
    
    return true;
  }

  Future<bool> addStockData(
    StockModel stockModel
  ) async {
    stockModel.id =  Uuid().v4();
    
    await ecgReference.doc(stockModel.id ).set(
      stockModel.toMap(),
    );
    
    return true;
  }

  Future<bool> setIncome(
    bool isIncome,
    double amount,
    String incomeType,
    String incomeId,
  ) async {
    Income income = Income(id: incomeId, isIncome: isIncome, amount: amount,incomeType: incomeType);
    await incomeReference.doc(income.id).set(
      income.toMap()
    );
    return true;
  }

  //update
  Future<bool> updateStockData(
    StockModel stockModel
  ) async {
    
    await ecgReference.doc(stockModel.id ).update(
      stockModel.toMap(),
    );
    
    return true;
  }

  Future<bool> addPatientToChanel(
    String channelingId,
    List<PatientModel> patientList,
  ) async {

    List<Map<String,dynamic>> _patientList = [];

    for (var element in patientList) {
      _patientList.add(element.toMap());
    }
    
    await channelingReference.doc(channelingId).update(
      {"patientList":_patientList}
    );
    
    return true;
  }

  Future<bool> updateDateTimeChanel(
    String channelingId,
    DateTime dateTime
  ) async {

    await channelingReference.doc(channelingId).update(
      {"dateTime":dateTime}
    );
    
    return true;
  }


  //get
  Future<List<ECGModel>> getECGList() async {
    QuerySnapshot querySnapshot = await ecgReference.get();
    List<ECGModel> _ecgList = [];
    for (var item in querySnapshot.docs) {
        _ecgList.add(
          ECGModel.fromMap(item.data() as Map<String, dynamic>)
        );
    }
    _ecgList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return _ecgList;
  }

  Future<List<StockModel>> getStockList(String stockType,String search) async {
    late QuerySnapshot querySnapshot;
    if(stockType.isNotEmpty && search.isNotEmpty){
      querySnapshot = await ecgReference.where("stockType",isEqualTo: stockType).where("searchList",arrayContains: search).get();
    }
    else if(stockType.isNotEmpty ){
      querySnapshot = await ecgReference.where("stockType",isEqualTo: stockType).get();
    }
    else if(search.isNotEmpty){
      querySnapshot = await ecgReference.where("searchList",arrayContains: search).get();
    }
    List<StockModel> _ecgList = [];
    for (var item in querySnapshot.docs) {
        _ecgList.add(
          StockModel.fromMap(item as Map<String, dynamic>)
        );
    }
    return _ecgList;
  }

  

  

  

  

  signOut() async {
    _user = null;
    name = null;
    // user = null;
    _auth.signOut();
    Get.offAll(() => const Login());
  }

  

  

  

    

    // print(_userList);

  
}
