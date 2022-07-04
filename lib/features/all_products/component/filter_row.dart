import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import '../../../core/constants/constants.dart';

class FilterProducts extends StatelessWidget {
  const FilterProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translateString("filter by ", "التصنيف بحسب"),
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.04),
              ),
             
              Icon(Icons.keyboard_arrow_left, color: colordeepGrey, size: w*0.07,),
            ],
          ),
        ),

          InkWell(
          onTap: (){},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translateString("Sort by ", "الترتيب بحسب"),
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.04),
              ),
             
              Icon(Icons.keyboard_arrow_left, color: colordeepGrey, size: w*0.07,),
            ],
          ),
        ),
      ],
    );
  }
}
