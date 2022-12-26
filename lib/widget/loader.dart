import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/base_provider.dart';
import '../res.dart';

class Loader extends StatelessWidget {
  Loader({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool loading = Provider.of<BaseProvider>(context).isLoading;
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