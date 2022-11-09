import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/constants.dart';
import '../../core/utiles/size_config.dart';
import '../../core/widgets/space_widget.dart';
import '../../translations/locale_keys.g.dart';

class PaymentDetailCard extends StatelessWidget {
  final String subtotal;
  final String total;
  final String shipping;
  final String discount;
  const PaymentDetailCard(
      {Key? key,
      required this.subtotal,
      required this.total,
      required this.shipping,
      required this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translateString("Sub total", "المجموع الفرعي")),
                Text(subtotal + translateString("R.S", "ر.س")),
              ],
            ),
            const VerticalSpace(value: 1),
            (shipping != "")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translateString("Shipping coast", "تكاليف الشحن ")),
                      Text(shipping + " " + translateString("R.S", "ر.س"))
                    ],
                  )
                : const SizedBox(),
            const VerticalSpace(value: 1),
            (prefs.getString("coupon_value") != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translateString("discount", "الخصم")),
                      Text(discount + " " + translateString("R.S", "ر.س")),
                    ],
                  )
                : const SizedBox(),
            const Divider(
              thickness: 2,
            ),
            const VerticalSpace(value: 1.5),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300),
              child: Row(
                children: [
                  Text(
                    LocaleKeys.total.tr(),
                    style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
                  ),
                  const Spacer(),
                  Text(
                    getTotalPrice() + " " + translateString("R.S", "ر.س"),
                    style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTotalPrice() {
    num totalPrice = num.parse(subtotal);
    if (shipping != "") {
      totalPrice =
          (num.parse(subtotal) + num.parse(shipping)) - num.parse(discount);
    } else {
      totalPrice = num.parse(subtotal) - num.parse(discount);
    }

    return totalPrice.toStringAsFixed(2).toString();
  }
}
