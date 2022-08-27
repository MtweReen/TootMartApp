// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/setting/setting_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/account/account.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_state.dart';
import 'package:toot_mart/features/layout/layout.dart';
import 'package:toot_mart/features/orders/presentation/orders_view.dart';
import 'package:toot_mart/features/profile%20screens/contact_us.dart';
import 'package:toot_mart/features/profile%20screens/exhibitions/exhibitions.dart';
import 'package:toot_mart/features/profile%20screens/info.dart';
import 'package:toot_mart/features/profile%20screens/setting.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../core/widgets/profile_item.dart';

class GuestView extends StatefulWidget {
  const GuestView({Key? key}) : super(key: key);

  @override
  State<GuestView> createState() => _GuestViewState();
}

class _GuestViewState extends State<GuestView> {
  bool isDeleted = false;
  @override
  void initState() {
    showDeleteButton()!.then((value) {
      setState(() {
        isDeleted = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state){},
      builder: (context,state){
        return kUser ==null ? SizedBox(
            height: SizeConfig.screenHeight,
            child: Center(child: CircularProgressIndicator(color: kMainColor,),)):SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (kToken  != null&&kUser!=null)
                          SizedBox(
                            width: SizeConfig.screenWidth!*0.4,
                            child: Text(
                              kUser!.body!.user!.name!,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.defaultSize! * 3),
                            ),
                          ),
                        if (kToken  != null&&kUser!=null) const HorizontalSpace(value: 1),
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
              if (kToken  == null&&kUser!=null)
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
                                kInside++;
                                AuthCubit.get(context)
                                    .changeUserState(AccountStates.LOGIN);
                              })),
                      SizedBox(
                        width: SizeConfig.defaultSize! * 18,
                        child: CustomStrockButton(
                            text: translateString('Register', 'تسجيل'),
                            onTap: () {
                              kInside++;
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
                    if (kToken  != null&&kUser!=null)
                      InkWell(
                        onTap: () {
                          kInside++;
                          AuthCubit.get(context)
                              .changeUserState(AccountStates.ACCOUNT_DETAILS);
                        },
                        child: ProfileCardItem(
                          title:
                          translateString("Account Details", "تفاصيل الحساب"),
                        ),
                      ),
                    if (kToken  != null&&kUser!=null)
                      SizedBox(
                        height: h * 0.04,
                      ),
                    if (kToken  != null&&kUser!=null)
                      InkWell(
                        onTap: () {
                          // kInside++;
                          // AuthCubit.get(context)
                          //     .changeUserState(AccountStates.ORDERS_VIEW);
                          MagicRouter.navigateTo(const OrdersView());
                        },
                        child: ProfileCardItem(
                          title: translateString("My orders", "طلباتي"),
                        ),
                      ),
                    if (kToken  != null&&kUser!=null)
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
                    if (kToken  != null&&kUser!=null)
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExhibitionsScreen())),
                        child: ProfileCardItem(
                          title: translateString("Exhibition sites", "مواقع المعارض"),
                        ),
                      ),
                    if (kToken  != null&&kUser!=null)
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
                                          .refundsModel!
                                          .body!
                                          .refunds!,
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
                    SizedBox(
                      height: h * 0.04,
                    ),
                    if (kToken  != null&&kUser!=null)
                      InkWell(
                        onTap: () {
                          AuthCubit.get(context).SignOut();

                        },
                        child: ProfileCardItem(
                          title: translateString("Log Out", "تسجيل الخروج"),
                        ),
                      ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    if (kToken  != null&&kUser!=null && isDeleted)
                      InkWell(
                        onTap: () {
                          print(kToken );
                          _showCustomDialog(context);
                        },
                        child: ProfileCardItem(
                          title: translateString("Delete Account", "مسح الحساب"),
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: SizeConfig.defaultSize! * 15,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: SizedBox.expand(
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const VerticalSpace(value: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translateString("Confirm delete account ?! ",
                            " تأكيد حزف الحساب ؟ "),
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: SizeConfig.defaultSize! * 5,
                              width: SizeConfig.defaultSize! * 13,
                              child: CustomGeneralButton(
                                  text: translateString("Ok", "تأكيد"),
                                  onTap: () {
                                    AuthCubit.get(context).deleteAccount();
                                    MagicRouter.navigateTo(const LayoutScreen(
                                      index: 0,
                                    ));
                                  })),
                          SizedBox(
                              height: SizeConfig.defaultSize! * 5,
                              width: SizeConfig.defaultSize! * 13,
                              child: CustomGeneralButton(
                                  text: LocaleKeys.cancel.tr(),
                                  onTap: () {
                                    MagicRouter.pop();
                                  })),
                          // CustomGeneralButton(text: 'text', onTap: (){}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
