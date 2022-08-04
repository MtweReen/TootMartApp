import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/order_detail/body.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: customAppbar(
              title: translateString("Order detail", "تفاصيل الطلب"),
              context: context,
              press: () => Navigator.pop(context),
              inLayout: false),
          body: ConditionalBuilder(
            condition: state is! GetOrderDetailLoadingState,
            builder: (BuildContext context) {
              return OrderDetailBody();
            },
            fallback: (BuildContext context) => Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
