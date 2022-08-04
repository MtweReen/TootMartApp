import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
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
        ? SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
          child: ListView.separated(
           primary: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderItem(
                quantity: "1",
                    index: index,
                    orderID: widget.orders[index].id.toString(),
                    orderName: widget.orders[index].orderNumber.toString(),
                    orderStatus: 'status',
                    total: widget.orders[index].total.toString(),
                  ),
              separatorBuilder: (context, index) => const Divider(
                    thickness: 2,
                  ),
              itemCount: widget.orders.length),
        )
        : Center(
          child: Text(
            translateString("no orders yet , shop now",
                "لا توجد طلبات بعد , تسوق الان"),
            style: headingStyle.copyWith(
                color: kMainColor, fontWeight: FontWeight.bold),
          ),
        );
  }
}
