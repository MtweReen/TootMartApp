import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/order_detail/order_detail.dart';
import '../../../../core/constants/constants.dart';
import 'order_item.dart';

class FinishedOrders extends StatefulWidget {
  final List order;
  const FinishedOrders({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<FinishedOrders> createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
  //List<Orders>? ordersCompleted;
  @override
  Widget build(BuildContext context) {
    return (widget.order.isNotEmpty)
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) =>
                    BlocConsumer<CheckOutCubit, CheckOutStates>(
                      listener: (context, state) {
                        if (state is GetOrderDetailSuccessState) {
                          MagicRouter.navigateTo(const OrderDetailScreen());
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            CheckOutCubit.get(context).getOrderDetail(
                                context: context,
                                orderId: widget.order[index].id);
                          },
                          child: OrderItem(
                            isrefundable:
                                widget.order[index].refundable.toString(),
                            quantity:
                                widget.order[index].productsAmount.toString(),
                            index: index,
                            orderID: widget.order[index].id.toString(),
                            orderName:
                                widget.order[index].orderNumber.toString(),
                            orderStatus: widget.order[index].status.toString(),
                            total: widget.order[index].total.toString(),
                          ),
                        );
                      },
                    ),
                separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                itemCount: widget.order.length),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translateString("no orders yet , shop now",
                    "لا توجد طلبات بعد , تسوق الان"),
                style: headingStyle.copyWith(
                    color: kMainColor, fontWeight: FontWeight.bold),
              ),
            ],
          );
  }
}
