import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../res.dart';

class Loader extends StatelessWidget {
  final bool loading;
  const Loader({Key? key,required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading? Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.5),
      child: const SpinKitRing(
        size: 50.0,
        color: AppColors.thirdColor,
      )
    ):SizedBox();
  }
}