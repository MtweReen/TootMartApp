import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import '../../../../core/router/router.dart';
import '../../../order_detail/order_detail.dart';
import 'order_item.dart';

class CurrentOrders extends StatefulWidget {
  final List orders;

  const CurrentOrders({Key? key, required this.orders}) : super(key: key);

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    return (widget.orders.isNotEmpty)
        ? ListView.separated(
          shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) =>
                BlocConsumer<CheckOutCubit, CheckOutStates>(
                  listener: (context, state) {
                    //  if(state is GetOrderDetailSuccessState){
                    //   MagicRouter.navigateTo(const OrderDetailScreen());
                    // }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        CheckOutCubit.get(context).getOrderDetail(
                            context: context,
                            orderId: widget.orders[index].id);
                        MagicRouter.navigateTo(const OrderDetailScreen());
                      },
                      child: OrderItem(
                        quantity: "1",
                        index: index,
                        orderID: widget.orders[index].id.toString(),
                        orderName:
                            widget.orders[index].orderNumber.toString(),
                        orderStatus: 'status',
                        total: widget.orders[index].total.toString(),
                      ),
                    );
                  },
                ),
            separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
            itemCount: widget.orders.length)
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
