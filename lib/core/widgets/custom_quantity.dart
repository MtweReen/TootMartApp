import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utiles/size_config.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({Key? key, required this.onTap, required this.child})
      : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8),
          height: SizeConfig.defaultSize! * 3,
          width: SizeConfig.defaultSize! * 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorGrey)),
          child: SizedBox(
            width: SizeConfig.defaultSize! * 2,
            child: child,
          )),
    );
  }
}
