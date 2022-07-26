import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/cart/componnent/checkout_bill.dart';
import 'package:toot_mart/features/checkout/presentation/checkout.dart';

import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/router/router.dart';
import '../../../business_logic/app_cubit/app_cubit.dart';
import 'shopping_item.dart';

class ShoppingCartBody extends StatelessWidget {
  const ShoppingCartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (true) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // if (AppCubit.get(context)
                    //     .cartModel!
                    //     .data!
                    //     .variations!
                    //     .isNotEmpty)
                    ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ShoppingItem(
                              context: context,
                              index: index,
                            ),
                        separatorBuilder: (context, index) =>
                            const VerticalSpace(value: 1),
                        itemCount: 2),
                    const VerticalSpace(value: 1.5),
                    Text(
                      'الأسعار بالريال السعودى شاملة 15% ضريبة',
                      style: headingStyle.copyWith(color: colorGrey),
                    ),
                    const VerticalSpace(value: 1.5),
                    Divider(
                      thickness: 1,
                      height: 1,
                      color: colorLightGrey,
                    ),
                    const VerticalSpace(value: 1.5),

                    // if (AppCubit.get(context)
                    //     .cartModel!
                    //     .data!
                    //     .variations!
                    //     .isEmpty)
                    //   SizedBox(
                    //       height: SizeConfig.defaultSize! * 32,
                    //       child: Center(
                    //         child: Text(
                    //           'LocaleKeys.shopping_cart_empty.tr()',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: SizeConfig.defaultSize! * 2),
                    //         ),
                    //       )),
                    // if (AppCubit.get(context)
                    //     .cartModel!
                    //     .data!
                    //     .variations!
                    //     .isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.total.tr(),
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize! * 2),
                          ),
                          const Spacer(),
                          Text(
                            '1000 رس',
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize! * 2),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpace(value: 2),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(15),
                        border: Border.all(
                            color: kMainColor, width: 2),
                        color: Colors.white,
                      ),
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(
                                    horizontal: 20),
                                border: InputBorder.none,
                                hintText:'ادخل الكوبون هنا ',
                              ),
                            ),
                          ),
                          Container(
                            color: kMainColor,
                            child: MaterialButton(
                              onPressed: () {
                              },
                              minWidth: 1,
                              child:Text('تفعيل',style: headingStyle.copyWith(color: Colors.white),)
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                    const CheckOutBill(),
                    const VerticalSpace(value: 5),
                    // if (AppCubit.get(context)
                    //     .cartModel!
                    //     .data!
                    //     .variations!
                    //     .isNotEmpty)
                    CustomGeneralButton(
                        text: 'إتمام عملية الشراء',
                        withBorder: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckoutScreen()));
                          // if (kUser != null) {
                          //   MagicRouter.navigateAndPopUntilFirstPage(
                          //       const CheckOutView());
                          // } else {
                          //   _showCustomDialog(context);
                          // }
                        }),
                    const VerticalSpace(value: 1),
                  ],
                ),
              );


        } else {
          return Container(
              color: Colors.white,
              child:
                  Center(child: CircularProgressIndicator(color: kMainColor)));
        }
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'LocaleKeys.you_must_signup_first.tr()',
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
                                  text: LocaleKeys.login.tr(),
                                  onTap: () {
                                    // AppCubit.get(context).selectedIndex = 1;
                                    // MagicRouter.navigateTo(
                                    //     const HomeLayoutView());
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
