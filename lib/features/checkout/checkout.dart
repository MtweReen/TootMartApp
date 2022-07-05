import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/checkout/componnent/boy.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({ Key? key }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: translateString("shipping options","خيارات الشحن "), context: context),
      body: const CheckoutBody(),
      
    );
  }
}