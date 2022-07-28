import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/setting/setting_cubit.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/account/account.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/profile%20screens/contact_us.dart';
import 'package:toot_mart/features/profile%20screens/exhibitions/exhibitions.dart';
import 'package:toot_mart/features/profile%20screens/info.dart';
import 'package:toot_mart/features/profile%20screens/setting.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../core/widgets/profile_item.dart';

class GuestView extends StatelessWidget {
  const GuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (kUser != null)
                      Text(
                        kUser!.body!.user!.name!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.defaultSize! * 3),
                      ),
                    if (kUser != null) const HorizontalSpace(value: 2),
                    Text(
                      translateString('Hello', 'مرحبا'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.defaultSize! * 3),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingScreen())),
                  child: Icon(Icons.settings_outlined,
                      size: SizeConfig.defaultSize! * 4),
                ),
              ],
            ),
          ),
          if (kUser == null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: SizeConfig.defaultSize! * 18,
                      child: CustomGeneralButton(
                          text: translateString('Log in', 'تسجيل الدخول'),
                          onTap: () {
                            AuthCubit.get(context)
                                .changeUserState(AccountStates.LOGIN);
                          })),
                  SizedBox(
                    width: SizeConfig.defaultSize! * 18,
                    child: CustomStrockButton(
                        text: translateString('Register', 'تسجيل'),
                        onTap: () {
                          AuthCubit.get(context)
                              .changeUserState(AccountStates.REGISTER);
                        }),
                  ),
                ],
              ),
            ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    AuthCubit.get(context)
                        .changeUserState(AccountStates.ACCOUNT_DETAILS);
                  },
                  child: ProfileCardItem(
                    title: LocaleKeys.account_details.tr(),
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  onTap: () {
                    AuthCubit.get(context)
                        .changeUserState(AccountStates.ORDERS_VIEW);
                  },
                  child: ProfileCardItem(
                    title: translateString("My orders", "طلباتي"),
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactusScreen())),
                  child: ProfileCardItem(
                    title: LocaleKeys.CONTACT_US.tr(),
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExhibitionsScreen())),
                  child: ProfileCardItem(
                    title: translateString("Exhibition sites", "مواقع المعارض"),
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                BlocConsumer<SettingCubit, SettingState>(
                  listener: (context, state) {
                   
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationScreen(
                                  body: SettingCubit.get(context).refundsModel!.body!.refunds!,
                                  title: translateString('Delivery and Returns',
                                      'التوصيل والمرتجعات')))),
                      child: ProfileCardItem(
                          title: translateString(
                              'Delivery and Returns', 'التوصيل والمرتجعات')),
                    );
                  },
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                BlocConsumer<SettingCubit, SettingState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationScreen(
                                  body: SettingCubit.get(context)
                                      .settingModel!
                                      .body!
                                      .privacy!,
                                  title: translateString(
                                      'privacy policy', 'سياسة الخصوصية')))),
                      child: ProfileCardItem(
                          title: translateString(
                              'privacy policy', 'سياسة الخصوصية')),
                    );
                  },
                ),
                // SizedBox(
                //   height: h * 0.06,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
