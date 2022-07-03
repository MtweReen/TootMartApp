import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/app_cubit/app_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../core/utiles/size_config.dart';

class CountrySelectWidget extends StatelessWidget {
  const CountrySelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: SizeConfig.screenWidth! * 0.7,
              child: Text(
                "تم تعيين موقع التطبيق الخاص بك على المملكة العربية السعودية (الريال السعودى",
                textAlign: TextAlign.center,
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: colordeepGrey,
                    fontSize: SizeConfig.screenWidth! * 0.04),
              ),
            ),
          ),
          const VerticalSpace(value: 5),
          CustomButtonWithIcon(
              textColor: (AppCubit.get(context).saudiCountry)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
              borderColor: (AppCubit.get(context).saudiCountry)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
              text: "السعودية",
              onTap: () {
                AppCubit.get(context).seledctCountry(saudi: true, kuwait: false);
              },
              icon: "asset/images/saudi.png"),
          const VerticalSpace(value: 3),
          CustomButtonWithIcon(
              textColor: (AppCubit.get(context).kuwaitCountry)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
              borderColor: (AppCubit.get(context).kuwaitCountry)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
              text: "الكويت",
              onTap: () {
                AppCubit.get(context).seledctCountry(saudi: false, kuwait: true);
              },
              icon: "asset/images/kweit.png"),
        ],
      ),
      listener: (context, state) {},
    );
  }
}
