import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/order_detail/body.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: translateString("Order detail", "تفاصيل الطلب"),
          context: context,
          press: () => Navigator.pop(context),
          inLayout: false),
       body: const OrderDetailBody(),   
    );
  }
}
