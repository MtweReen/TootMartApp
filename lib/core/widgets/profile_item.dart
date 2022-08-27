import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import '../constants/colors.dart';

class ProfileCardItem extends StatelessWidget {
  final String title;
  final Color? color;
  const ProfileCardItem({Key? key, required this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: h * 0.07,
      padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(w * 0.02),
        boxShadow: [
          BoxShadow(
              color: colorLightGrey.withOpacity(0.3),
              offset: const Offset(0, 3),
              spreadRadius: 3,
              blurRadius: 3),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: headingStyle.copyWith(
                    color: color != null ? Colors.white : colordeepGrey),
              ),
            ],
          ),
          Icon(
            (prefs.getString("lang").toString() == "en")
                ? Icons.keyboard_arrow_right
                : Icons.keyboard_arrow_left,
            size: w * 0.1,
            color: color != null ? Colors.white : colordeepGrey,
          ),
        ],
      ),
    );
  }
}
