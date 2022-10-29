import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import '../../../../core/utiles/size_config.dart';
import 'current_orders.dart';
import 'finished_orders.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({Key? key}) : super(key: key);

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  @override
  void initState() {
    CheckOutCubit.get(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: customAppbar(
              inLayout: false,
              context: context,
              title: translateString("My Orders", "طلباتي"),
              press: () {
                MagicRouter.pop();
              }),
          body: ConditionalBuilder(
            condition: state is! GetOrderDetailLoadingState ||
                CheckOutCubit.get(context).orderModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
            builder: (context) => SingleChildScrollView(

              child: Container(
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
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            height: SizeConfig.defaultSize! * 6.5,
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
                          SizedBox(
                            height: SizeConfig.screenHeight! * 1.1,
                            child: TabBarView(
                              children: [
                                CurrentOrders(
                                  orders: CheckOutCubit.get(context)
                                      .orderModel!
                                      .body!
                                      .ordersUnderProcess!,
                                ),
                                FinishedOrders(
                                  order: CheckOutCubit.get(context)
                                      .orderModel!
                                      .body!
                                      .ordersCompleted!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
