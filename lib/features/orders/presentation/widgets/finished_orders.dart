import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../translations/locale_keys.g.dart';
import 'order_item.dart';

class FinishedOrders extends StatelessWidget {
  const FinishedOrders({Key? key,}) : super(key: key);
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
    } else {
      return SizedBox(
        height: SizeConfig.screenHeight,
          child: Center(
        child: Text(
          LocaleKeys.there_is_no_orders_yet.tr(),
          style: TextStyle(
              color: kMainColor, fontSize: SizeConfig.defaultSize! * 2),
        ),
      ));
    }
  }
}
