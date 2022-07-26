import 'package:toot_mart/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../../../core/utiles/size_config.dart';
import '../../business_logic/orders_cubit.dart';
import '../../business_logic/orders_states.dart';
import 'current_orders.dart';
import 'finished_orders.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersStates>(
        builder: (context, state) {
          if (true) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  const VerticalSpace(value: 2),
                  Text(
                    LocaleKeys.orders.tr(),
                    style: headingStyle.copyWith(color: Colors.black),
                  ),
                  const VerticalSpace(value: 3),
                  // if (OrdersCubit.get(context)
                  //             .ordersModel!
                  //             .data!
                  //             .ordersCompleted!.isNotEmpty ||
                  //     OrdersCubit.get(context)
                  //             .ordersModel!
                  //             .data!
                  //             .ordersUnderProcess!.isNotEmpty)
                    DefaultTabController(
                        length: 2,
                        child: Column(
                            children: [
                              Container(
                                height: SizeConfig.defaultSize!*6.5,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      30.0,
                                    ),
                                    border: Border.all(color: Colors.grey)),
                                child: TabBar(
                                  labelColor: Colors.white,
                                  labelStyle:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                  indicatorColor: Colors.white,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: kMainColor),
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(
                                      text: LocaleKeys.current_orders.tr(),
                                    ),
                                    Tab(
                                      text: LocaleKeys.finished_orders.tr(),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalSpace(value: 2),
                              // if (OrdersCubit.get(context).ordersModel != null)
                                SizedBox(
                                  height: SizeConfig.screenHeight,
                                  child: const TabBarView(
                                    children: [
                                      CurrentOrders(),
                                      FinishedOrders(),
                                    ],
                                  ),
                                ),
                           //   if (OrdersCubit.get(context).ordersModel == null)
                            //   Text(LocaleKeys.there_is_no_orders_yet.tr()),
                            ],
                          ),

                    ),
                  // if (OrdersCubit.get(context)
                  //             .ordersModel!
                  //             .data!
                  //             .ordersCompleted!.isEmpty &&
                  //     OrdersCubit.get(context)
                  //             .ordersModel!
                  //             .data!
                  //             .ordersUnderProcess!.isEmpty)
                  //   Center(
                  //     child: Text(
                  //   LocaleKeys.there_is_no_orders_yet.tr(),
                  //   style: TextStyle(
                  //       color: kMainColor,
                  //       fontSize: SizeConfig.defaultSize! * 2),
                  //     ),
                  //   )
                ],
              ),
            );
          } else {
            if (kUser == null) {
              return Center(
                child: Text(
                  LocaleKeys.you_must_signup_first.tr(),
                  style: TextStyle(
                      color: kMainColor,
                      fontSize: SizeConfig.defaultSize! * 2,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: kMainColor),
            );
          }
        },
      );

  }
}
