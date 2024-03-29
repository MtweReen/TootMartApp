// ignore_for_file: must_be_immutable, unused_element

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

class OrderItem extends StatelessWidget {
  final String orderName;
  final String orderID;
  final String orderStatus;
  final String total;
  final String quantity;
  final String isrefundable;
  OrderItem(
      {Key? key,
      required this.index,
      required this.isrefundable,
      this.isReplacment,
      required this.orderName,
      required this.orderID,
      required this.orderStatus,
      required this.total,
      required this.quantity})
      : super(key: key);
  // List<Orders>? orders;
  bool? isReplacment = false;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.transparent),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  kLogo,
                  color: kMainColor,
                  height: SizeConfig.defaultSize! * 8,
                ),
                const HorizontalSpace(value: 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderName,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '#$orderID',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.defaultSize! * 1),
                            ),
                          )
                        ],
                      ),
                      const VerticalSpace(value: 0.5),
                      Text(
                        '${LocaleKeys.quantity.tr()} : $quantity',
                        style: TextStyle(fontSize: SizeConfig.defaultSize),
                      ),
                      const VerticalSpace(value: 0.5),
                      Row(
                        children: [
                          Text(
                            orderStatus,
                            style: TextStyle(fontSize: SizeConfig.defaultSize),
                          ),
                          if (isReplacment != true) const Spacer(),
                          (isrefundable == "true")
                              ? SizedBox(
                                  child: CustomTextButton(
                                      text:
                                          translateString("refund", 'إسترجاع'),
                                      size: SizeConfig.defaultSize! * 1.6,
                                      color: kMainColor,
                                      isUnderLine: true,
                                      onPressed: () {
                                        _showCustomDialog(context, orderID);
                                      }),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.total.tr()),
                Text('$total ${LocaleKeys.rs.tr()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showCustomDialog(BuildContext context, orderId) {
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
                        'هل تريد استرجاع المنتج ؟',
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize! * 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocConsumer<CheckOutCubit, CheckOutStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: SizeConfig.defaultSize! * 5,
                                  width: SizeConfig.defaultSize! * 12,
                                  child: CustomGeneralButton(
                                      text: LocaleKeys.confirm.tr(),
                                      onTap: () {
                                        CheckOutCubit.get(context)
                                            .refundOrder(orderId: orderId);
                                        Navigator.pop(context);
                                      })),
                              SizedBox(
                                  height: SizeConfig.defaultSize! * 5,
                                  width: SizeConfig.defaultSize! * 12,
                                  child: CustomGeneralButton(
                                      text: LocaleKeys.cancel.tr(),
                                      onTap: () {
                                        MagicRouter.pop();
                                      })),
                              // CustomGeneralButton(text: 'text', onTap: (){}),
                            ],
                          ),
                        );
                      },
                    )
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
