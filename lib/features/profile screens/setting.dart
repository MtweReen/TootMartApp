import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/utiles/size_config.dart';
import '../../core/widgets/space_widget.dart';
import '../country/country.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
          title: translateString("Setting", "الاعدادات"),
          context: context,
          press: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.LANG.tr(),
                      style: headingStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenWidth! * 0.045),
                    ),
                    const VerticalSpace(value: 1.5),
                    Text(
                      "اللغه العربية",
                      style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth! * 0.045),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CountryScreen(fromSetting: true,))),
                  child: Text(
                    translateString("Edit", "تعديل"),
                    style: headingStyle.copyWith(
                        color: kMainColor,
                        decorationColor: kMainColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth! * 0.045),
                  ),
                ),
              ],
            ),
            const VerticalSpace(value: 2),
            Divider(
              color: colorBetrolly,
            ),
            const VerticalSpace(value: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateString("Country", "الدولة"),
                      style: headingStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenWidth! * 0.045),
                    ),
                    const VerticalSpace(value: 1.5),
                    Text(
                      " السعودية",
                      style: headingStyle.copyWith(
                          color: colordeepGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth! * 0.045),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  const CountryScreen(fromSetting: true,))),
                  child: Text(
                    translateString("Edit", "تعديل"),
                    style: headingStyle.copyWith(
                        color: kMainColor,
                        decorationColor: kMainColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth! * 0.045),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
