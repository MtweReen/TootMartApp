import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/app_cubit/app_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../core/utiles/size_config.dart';

class LanguageSelectWidget extends StatelessWidget {
  const LanguageSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: SizeConfig.screenWidth! * 0.7,
                child: Text(
                  "لغة التطبيق الخاصة بك هي العربية",
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
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.3,
                  child: CustomGeneralButton(
                      borderColor: (AppCubit.get(context).arLanguage)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
                    text: "عربي",
                    color: Colors.white,
                    textColor: (AppCubit.get(context).arLanguage)
                        ? kMainColor
                        : kMainColor.withOpacity(0.4),
                    onTap: () {
                      AppCubit.get(context)
                          .seledctLanguage(ar: true, en: false);
                    },
                  ),
                ),
                const HorizontalSpace(value: 3),
                SizedBox(
                  width: SizeConfig.screenWidth! * 0.3,
                  child: CustomGeneralButton(
                    borderColor: (AppCubit.get(context).enLanguage)
                  ? kMainColor
                  : kMainColor.withOpacity(0.4),
                    text: "English",
                    onTap: () {
                      AppCubit.get(context)
                          .seledctLanguage(ar: false, en: true);
                    },
                    color: Colors.white,
                    textColor: (AppCubit.get(context).enLanguage)
                        ? kMainColor
                        : kMainColor.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
