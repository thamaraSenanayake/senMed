import 'package:balance/screens/homScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'providers/firebase_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => FirebaseProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'balance',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  Container(),
      ),
    );
  }
}

