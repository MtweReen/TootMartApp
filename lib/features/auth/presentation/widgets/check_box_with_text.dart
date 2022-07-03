import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utiles/size_config.dart';

class CustomCheckBoxWithText extends StatefulWidget {
  const CustomCheckBoxWithText({Key? key,required this.text}) : super(key: key);
  final String text;

  @override
  State<CustomCheckBoxWithText> createState() => _CustomCheckBoxWithTextState();
}

class _CustomCheckBoxWithTextState extends State<CustomCheckBoxWithText> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        SizedBox(
            height: SizeConfig.defaultSize! * 5.5,
            width: SizeConfig.defaultSize! * 5.5,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: Colors.grey // Your color
                  ),
              child: Checkbox(
                  activeColor: kMainColor,
                  value: isChecked,
                  onChanged: (value) {
                    _handleRememberme(value!);
                  }),
            )
        ),
        Text(widget.text,
            style: TextStyle(
              color: kMainColor,
              fontSize: SizeConfig.defaultSize!*1.8,
            )),
      ],
    );
  }



  //handle remember me function
  void _handleRememberme(bool value) {
    isChecked = value;
    // CasheHelper.saveBool(key: 'remember_me', value: value);
    setState(() {
      isChecked = value;
    });
  }
}


