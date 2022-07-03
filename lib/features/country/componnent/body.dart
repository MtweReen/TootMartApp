import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/features/onboarding/onboarding.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../../core/widgets/space_widget.dart';
import 'country_select_widget.dart';
import 'language_select.dart';

class CountrySelectionBody extends StatefulWidget {
  const CountrySelectionBody({Key? key}) : super(key: key);

  @override
  State<CountrySelectionBody> createState() => _CountrySelectionBodyState();
}

class _CountrySelectionBodyState extends State<CountrySelectionBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.1,
          horizontal: SizeConfig.screenWidth! * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const CountrySelectWidget(),
          const VerticalSpace(value: 5),
          const LanguageSelectWidget(),
          const VerticalSpace(value: 5),
          CustomGeneralButton(
            text: translateString("Continue", "استمر"),
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const OnBoardingScreen())),
          ),
        ],
      ),
    );
  }
}
