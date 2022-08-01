import 'package:flutter/material.dart';
import 'order_item.dart';

class CurrentOrders extends StatelessWidget {
  const CurrentOrders({Key? key}) : super(key: key);
  // List<Orders>? ordersUnderProcess;
  @override
  Widget build(BuildContext context) {
    if (true) {
      return ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => OrderItem(
                index: index,
              ),
          separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
          itemCount: 5);
    }
  }
}
