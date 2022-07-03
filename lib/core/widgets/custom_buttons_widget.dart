import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../helper/extentions.dart';
import '../utiles/size_config.dart';


class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color,
      this.textColor,
      this.iconImage,
      this.withBorder})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final String? iconImage;
  final Color? textColor;
  final bool? withBorder;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.08,
        width: w,
        decoration: BoxDecoration(
            color: color ?? kMainColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'URW DIN Arabic'),
                ),
              ),
              (iconImage != null)
                  ? SizedBox(
                      width: w * 0.03,
                    )
                  : const SizedBox(),
              (iconImage != null)
                  ? Image.asset(
                      iconImage!,
                      color: Colors.white,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomStrockButton extends StatelessWidget {
  const CustomStrockButton(
      {Key? key, required this.text, required this.onTap, this.color})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.08,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: HexColor.fromHex('#8B8B8B'),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon(
      {Key? key,
      this.color,
      required this.icon,
      required this.text,
      required this.onTap})
      : super(key: key);
  final Color? color;
  final String icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.08,
        width: w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorRed,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            Text(
              text,
              style: headingStyle,
              textAlign: TextAlign.left,
            ),
             SizedBox(width: w*0.02,),
               Image.asset(
              icon,
              color: color,
            ),
           
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.size,
      this.color,
      this.isUnderLine})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double? size;
  final Color? color;
  final bool? isUnderLine;

  @override
  Widget build(BuildContext context) {
    return isUnderLine == true
        ? TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: color,
                fontSize: size ?? SizeConfig.defaultSize! * 5.5,
              ),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: headingStyle.copyWith(
                color: color,
                fontSize: size ?? 10,
              ),
            ),
          );
  }
}
