import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utiles/size_config.dart';
import '../../../business_logic/cart/cart_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../checkout/presentation/componnent/add_location_view.dart';

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
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translateString("Sub total", "المجموع الفرعي")),
                    Text(CartCubit.get(context)
                            .cartModel!
                            .body!
                            .total
                            .toString() +
                        translateString("R.S", "ر.س")),
                  ],
                ),
                const VerticalSpace(value: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translateString("Shipping coast", "تكاليف الشحن ")),
                    (AddLocationView.shippingCoast != null)
                        ? Text("${AddLocationView.shippingCoast} " +
                            translateString("R.S", "ر.س"))
                        : Text(translateString("depend on city", "حسب المدينة"))
                  ],
                ),
                const VerticalSpace(value: 1),
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

                (prefs.getString("coupon_value") != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translateString("discount", "الخصم")),
                          Text(prefs.getString("coupon_value").toString() +
                              translateString("R.S", "ر.س")),
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
                        getTotal(
                            subtotal: num.parse(CartCubit.get(context)
                                .cartModel!
                                .body!
                                .total!)),
                        style: TextStyle(fontSize: SizeConfig.defaultSize! * 2),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String getTotal({required num subtotal}) {
    num total = 0;
    if (prefs.getString("coupon_total") != null) {
      if (AddLocationView.shippingCoast != null) {
        total =
            (subtotal + num.parse(AddLocationView.shippingCoast.toString())) -
                num.parse(prefs.getString("coupon_total").toString());
      } else {
        total =
            subtotal - num.parse(prefs.getString("coupon_total").toString());
      }
    } else {
      if (AddLocationView.shippingCoast != null) {
      total = subtotal + num.parse(AddLocationView.shippingCoast.toString());
    } else {
      total = subtotal;
    }
    }
    return total.toStringAsFixed(2).toString();
  }
}
