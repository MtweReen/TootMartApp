import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
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
                primary: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => OrderItem(
                  quantity: "1",
                      index: index,
                      orderID: widget.order[index].id.toString(),
                      orderName: widget.order[index].orderNumber.toString(),
                      orderStatus: 'status',
                      total: widget.order[index].total.toString(),
                    ),
                separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                itemCount: widget.order.length),
          )
        : Center(
            child: Text(
              translateString(
                  "no orders yet , shop now", "لا توجد طلبات بعد , تسوق الان"),
              style: headingStyle.copyWith(
                  color: kMainColor, fontWeight: FontWeight.bold),
            ),
          );
  }
}
