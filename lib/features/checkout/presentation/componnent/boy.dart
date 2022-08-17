// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timelines/timelines.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/helper/functions/show_toast.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/checkout_complete_view.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/shipping_view.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';
import 'add_location_view.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({Key? key}) : super(key: key);

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

List<String> titleButton = [
  'الذهاب الي الشحن',
  'إتمام عملية الشراء',
  'إتمام عملية الدفع'
];
List<String> icons = [
  'asset/images/loc.png',
  'asset/images/box.png',
  'asset/images/credit.png',
];

List<String> titles = [
  'العنوان',
  'الشحن',
  'الدفع',
];
int currentPage = 0;

class _CheckoutBodyState extends State<CheckoutBody> {
  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CheckOutCubit, CheckOutStates>(
        listener: (context, state) {
          if (state is CreateOrderSuccessState) {
            CheckOutCubit.get(context).getOrders();
            CartCubit.get(context).getcart();
            currentPage = 0;
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpace(value: 2),
              SizedBox(
                height: SizeConfig.defaultSize! * 10,
                // width: SizeConfig.defaultSize!*30,
                child: Timeline.custom(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return FixedTimeline(
                        direction: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: currentPage >= index
                                        ? kMainColor
                                        : colorGrey,
                                    borderRadius: BorderRadius.circular(20)),
                                width: SizeConfig.defaultSize! * 7,
                                height: SizeConfig.defaultSize! * 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(icons[index]),
                                ),
                              ),
                              Text(
                                titles[index],
                                style: headingStyle,
                              ),
                            ],
                          ),
                          if (index != 2)
                            SizedBox(
                              height: 50.0,
                              width: SizeConfig.defaultSize! * 6,
                              child: DashedLineConnector(
                                color: currentPage >= index
                                    ? kMainColor
                                    : colorGrey,
                                thickness: 3,
                                dash: 5,
                                gap: 5,
                              ),
                            ),
                        ],
                      );
                    },
                    childCount: 3,
                    semanticIndexOffset: 2,
                  ),
                ),
              ),
              const VerticalSpace(value: 1),
              if (currentPage == 0) const AddLocationView(),
              if (currentPage == 1) const ShippingView(),
              if (currentPage > 2) const CheckOutCompleteView(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: CustomGeneralButton(
                    text:
                        titleButton[CheckOutCubit.get(context).currentTimeLine],
                    withBorder: true,
                    onTap: () {
                      if (CheckOutCubit.get(context).currentTimeLine < 2) {
                        if (currentPage == 0) {
                          if (AddLocationView.selected != null) {
                            setState(() {
                              currentPage++;
                            });
                            // CheckOutCubit.get(context)
                            //     .moveInTimeLine(currentPage++);
                          } else {
                            Fluttertoast.showToast(
                              msg: translateString("you must choose Address",
                                  "يجب اختيار عنوان الشحن"),
                              textColor: Colors.white,
                              backgroundColor: colorRed,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        } else {
                          setState(() {
                            currentPage++;
                          });
                          // CheckOutCubit.get(context)
                          //     .moveInTimeLine(currentPage++);
                        }
                      }

                      if (currentPage > 2) {
                        if (CasheHelper.getData(key: 'payment_type') != null) {
                          CheckOutCubit.get(context).createOrder();
                        } else {
                          showToast(
                              msg: translateString(
                                  'you must select payment type',
                                  'يجب عليك اختيار طريقة للدفع'),
                              state: ToastStates.ERROR);
                        }
                      }
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
