import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/custom_app_bar.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../constants/constants.dart';
import '../utiles/size_config.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image:  DecorationImage(
          image: AssetImage(kBgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const CustomAppBar(),
          const VerticalSpace(value: 2),
          child
        ],
      ),
    );
  }
}
