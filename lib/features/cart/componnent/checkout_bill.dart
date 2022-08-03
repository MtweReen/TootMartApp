import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utiles/size_config.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../translations/locale_keys.g.dart';

class CheckOutBill extends StatelessWidget {
  const CheckOutBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var endTotal = double.parse(
    //         CasheHelper.getData(key: 'totalWithShippingCheckOut').toString()) +
    //     double.parse(CheckOutCubit.get(context).shippingPrice.toString());
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
              children: const [
                Text('المجموع الفرعي'),
                Text(
                    '400 رس'),
              ],
            ),
            const VerticalSpace(value: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('رسوم الشحن'),
                Text(
                    '400 رس'),
              ],
            ),
            // const VerticalSpace(value: 1),
         //   if (CheckOutCubit.get(context).value != null)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Text(
              //       'رسوم الدفع عند الاستلام',
              //       style: TextStyle(color: Colors.grey),
              //     ),
              //     Text(
              //         '200 رس'),
              //   ],

              // ),
            const VerticalSpace(value: 1),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('خصم'),
                Text(
                    '00 رس'),
              ],
            ),
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
                    '1000 رس',
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
}
