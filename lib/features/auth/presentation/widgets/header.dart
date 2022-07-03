import 'package:flutter/material.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utiles/size_config.dart';

class Header extends StatelessWidget {
  const Header({Key? key,required this.text,required this.withBackBtn}) : super(key: key);
  final String text;
  final bool withBackBtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainColor.withOpacity(0.3),
      ),
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize! * 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(withBackBtn)

       InkWell(
           onTap: (){
             MagicRouter.pop();
           },
           child: Icon(Icons.arrow_left,size: SizeConfig.defaultSize!*6,)),
          if(withBackBtn)
    const HorizontalSpace(value: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
