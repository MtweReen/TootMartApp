// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/checkout_complete_view.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/shipping_view.dart';

import '../../../../core/widgets/custom_buttons_widget.dart';
import '../../../layout/layout.dart';
import 'add_location_view.dart';

class CheckoutBody extends StatefulWidget {
  CheckoutBody({Key? key}) : super(key: key);
  int currentPage = 0;

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

class _CheckoutBodyState extends State<CheckoutBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CheckOutCubit, CheckOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpace(value: 2),
              SizedBox(
                height: SizeConfig.defaultSize!*10,
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
                                    color: widget.currentPage >= index
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
                                color: widget.currentPage >= index
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
              if (widget.currentPage == 0)
                const AddLocationView(),
              if (widget.currentPage == 1)
                const ShippingView(),
              if (widget.currentPage == 2)
                const CheckOutCompleteView(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: CustomGeneralButton(
                    text:
                        titleButton[CheckOutCubit.get(context).currentTimeLine],
                    withBorder: true,
                    onTap: () {
                      if (CheckOutCubit.get(context).currentTimeLine < 2) {
                        CheckOutCubit.get(context)
                            .moveInTimeLine(widget.currentPage++);
                      }
                      if (widget.currentPage == 3) {
                        MagicRouter.navigateTo(const LayoutScreen(index: 0));
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
