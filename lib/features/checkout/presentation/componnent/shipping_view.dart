import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/cart/componnent/shopping_item.dart';

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
            Container(
              color: Colors.green,
              child: ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'ملخص المنتجات',
                              style: TextStyle(color: Colors.black),
                            ),
                            VerticalSpace(value: 1),
                            Text(
                              '3 منتجات',
                              style: TextStyle(color: Colors.black),
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
                        image: '',
                        name: '',
                        price: '',
                        quantity: '1', cartId: 0,
                      ),
                      itemCount: 3,
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
                    'توصيل سريع(خلال 3-7 ايام عمل)',
                    style: headingStyle.copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [Text('تكاليف الشحن'), Text('مجاني')],
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