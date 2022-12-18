import 'package:flutter/material.dart';

import '../../res.dart';
import '../dropDown.dart';

class OtherCharges extends StatelessWidget {
  final Function removeOtherCharge;
  const OtherCharges({Key? key, required this.removeOtherCharge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              removeOtherCharge();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle
              ),
              child: const Icon(
                Icons.remove,
                color: AppColors.thirdColor,
              ),
            ),
          ),
          CustomDropDown(width: (MediaQuery.of(context).size.width-140), value: null, valueList: [], onChange: (val){},hint: "Add Other Charges",),
        ],
      ),
    );
  }
}