import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';

import 'componnent/boy.dart';




class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({ Key? key }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CheckOutCubit(),
      child: Scaffold(
        appBar: customAppbar(title: translateString("shipping options","خيارات الشحن "), context: context),
        body: CheckoutBody(),

      ),
    );
  }
}