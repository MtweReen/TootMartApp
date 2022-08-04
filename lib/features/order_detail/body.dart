import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/order_detail/pay_detail.dart';
import 'package:toot_mart/features/order_detail/product_card.dart';

class OrderDetailBody extends StatefulWidget {
  const OrderDetailBody({Key? key}) : super(key: key);

  @override
  State<OrderDetailBody> createState() => _OrderDetailBodyState();
}

class _OrderDetailBodyState extends State<OrderDetailBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CheckOutCubit.get(context).singleOrderModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          ),
          builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight! * 0.02,
                horizontal: SizeConfig.screenWidth! * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => OrderCardItem(
                    image: CheckOutCubit.get(context)
                        .singleOrderModel!
                        .body!
                        .products![index]
                        .image!,
                    name: CheckOutCubit.get(context)
                        .singleOrderModel!
                        .body!
                        .products![index]
                        .title!,
                    price: CheckOutCubit.get(context)
                        .singleOrderModel!
                        .body!
                        .products![index]
                        .price!
                        .toString(),
                    quantity: '1',
                  ),
                  separatorBuilder: (context, index) =>
                      const VerticalSpace(value: 2),
                  itemCount: CheckOutCubit.get(context)
                      .singleOrderModel!
                      .body!
                      .products!
                      .length,
                ),
                const VerticalSpace(value: 3),
                PaymentDetailCard(
                  discount: '0.0',
                  subtotal: CheckOutCubit.get(context)
                      .singleOrderModel!
                      .body!
                      .order!
                      .subTotal!
                      .toString(),
                  total:  CheckOutCubit.get(context)
                      .singleOrderModel!
                      .body!
                      .order!
                      .total!
                      .toString(),
                  shipping: '0.0',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}