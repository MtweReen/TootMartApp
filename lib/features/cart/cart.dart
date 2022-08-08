import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import '../../business_logic/cart/cart_cubit.dart';
import 'componnent/shopping_cart_body.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    CartCubit.get(context).getcart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppbar(title: 'عربة التسوق', context: context, inLayout: true),
      body: ShoppingCartBody(),
    );
  }
}
