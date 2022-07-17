import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class OrderBill extends StatelessWidget {
  const OrderBill({Key? key, this.index}) : super(key: key);
  //final List<Orders>? orders;
  final int? index;
  @override
  Widget build(BuildContext context) {
    // var totalWithShipping = double.parse(orders![index!].total!) +
    //     double.parse(orders![index!].shipping!.cost!);
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
            Text(LocaleKeys.shipping_address.tr()),
            const VerticalSpace(value: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.custom_price.tr()),
                Text('100' + '  ${LocaleKeys.rs.tr()}'),
              ],
            ),
            const VerticalSpace(value: 1),
            //   if(CheckOutCubit.get(context).value != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LocaleKeys.shipping_to.tr()} name',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text('100 ${LocaleKeys.rs.tr()}'),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.total.tr()),
                Text('100' '  ${LocaleKeys.rs.tr()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
