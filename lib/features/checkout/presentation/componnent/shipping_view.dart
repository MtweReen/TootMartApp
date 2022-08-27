import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/cart/componnent/shopping_item.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/add_location_view.dart';

import '../../../../core/constants/colors.dart';

class ShippingView extends StatefulWidget {
  const ShippingView({Key? key}) : super(key: key);

  @override
  State<ShippingView> createState() => _ShippingViewState();
}

class _ShippingViewState extends State<ShippingView> {
  bool _expanded1 = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: colorLightGrey,
            ),
            const VerticalSpace(value: 2),
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  color: Colors.green,
                  child: ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 1000),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translateString(
                                      "Products Summary", "ملخص المنتجات"),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const VerticalSpace(value: 1),
                                Text(
                                  translateString(
                                      "${CartCubit.get(context).cartModel!.body!.carts!.length} products",
                                      "${CartCubit.get(context).cartModel!.body!.carts!.length} منتجات"),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        },
                        body: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) => ShoppingItem(
                            context: context,
                            index: index,
                            image: CartCubit.get(context).cartModel!.body!.carts![index].productImage!,
                            name: CartCubit.get(context).cartModel!.body!.carts![index].productTitle!,
                            price: CartCubit.get(context).cartModel!.body!.carts![index].price!.toString(),
                            quantity: CartCubit.get(context).cartModel!.body!.carts![index].quantity!,
                            cartId: CartCubit.get(context).cartModel!.body!.carts![index].id!,
                          ),
                          itemCount: CartCubit.get(context).cartModel!.body!.carts!.length,
                        ),
                        isExpanded: _expanded1,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: Colors.grey,
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded1 = !_expanded1;
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            const VerticalSpace(value: 2),
            Divider(
              height: 1,
              thickness: 1,
              color: colorLightGrey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    translateString(
                        "fast delivery withien ${AddLocationView.dayfrom} - ${AddLocationView.daysto} dsays",
                        "توصيل سريع خلال  ${AddLocationView.dayfrom} - ${AddLocationView.daysto}  أيام"),
                    style: headingStyle.copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(translateString("Shipping coast", "تكاليف الشحن ")),
                      (AddLocationView.shippingCoast != null)
                          ? Text("${AddLocationView.shippingCoast} " +
                              translateString("R.S", "ر.س"))
                          : Text(translateString("free shipping", "شحن مجاني"))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Column(
// children: [
//
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 50, vertical: 5),
// child:CustomGeneralButton(
// text: LocaleKeys.send.tr(),
// onTap: () {
//
// })
//
// ),
// ],
// ),