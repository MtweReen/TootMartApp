import 'package:flutter/material.dart';
import 'order_item.dart';

class FinishedOrders extends StatelessWidget {
  const FinishedOrders({
    Key? key,
  }) : super(key: key);
  //List<Orders>? ordersCompleted;

  @override
  Widget build(BuildContext context) {
    if (true) {
      return ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) => OrderItem(
                index: index,
                //   orders: ordersCompleted!.reversed.toList(),
              ),
          separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
          itemCount: 3);
    }
  }
}
