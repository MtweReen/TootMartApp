import 'package:flutter/material.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/payment_type.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../cart/componnent/checkout_bill.dart';

class CheckOutCompleteView extends StatelessWidget {
  const CheckOutCompleteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: colorLightGrey,
            ),
            VerticalSpace(value: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PaymentType(),
            ),
            VerticalSpace(value: 2),
            Divider(
              height: 1,
              thickness: 1,
              color: colorLightGrey,
            ),
            VerticalSpace(value: 2),
            const CheckOutBill(),
          ],
        ),
      ),
    );
  }
}
