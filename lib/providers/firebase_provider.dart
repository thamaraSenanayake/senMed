import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import '../res/platform_dialogue.dart';
// import 'base_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_provider.dart';
// import 'package:get/get.dart';

class FirebaseProvider  extends BaseProvider {
  late FirebaseStorage firebaseStorage;
  late FirebaseAuth _auth;
  late CollectionReference stockReference;
  auth.User? _user;
  auth.User? get firebaseUser => _user;
  String? name;

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

  Future<List<StockModel>> getStockList() async {
    stockReference =  FirebaseFirestore.instance.collection(_auth.currentUser!.email!);
    QuerySnapshot querySnapshot = await stockReference.get();
    List<StockModel> _userList = [];
    for (var item in querySnapshot.docs) {
      //  var a = item;
        // var map = json.decode(item.data);
        // print(item.get("userId"));
        _userList.add(
          StockModel.fromMap(item as Map<String, dynamic>)
        );

      
    }
    return _userList;
  }

  Future addStock(StockModel stockModel) async {
    

    

    await stockReference.doc(stockModel.name).set(
      stockModel.toMap()
    );

  }

  // Future<void> updateDownloadData(String userId) async {
  //   await userReference.doc(userId).update({"isDownload": true});
  // }

  

  

  

  // signOut() async {
  //   _user = null;
  //   name = null;
  //   user = null;
  //   _auth.signOut();
    // Get.offAll(() => const LoginScreen());
  // }

  

  

  

    

    // print(_userList);

  
}
