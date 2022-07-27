import 'package:toot_mart/core/widgets/custom_drawer.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utiles/size_config.dart';

import 'order_bill.dart';

class OrderItemDetails extends StatelessWidget {
  const OrderItemDetails({Key? key, this.index})
      : super(key: key);

  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              Text(
                LocaleKeys.orders_details.tr(),
                style: TextStyle(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize! * 2.5),
              ),
              const VerticalSpace(value: 2),
              Container(
                color: Colors.transparent,
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => _productItem(
                    index: index,
                ),
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) =>
                      const VerticalSpace(value: 1),
                ),
              ),
              OrderBill(index: index),
              const SizedBox(
                height: 100,
              ),
              //  OrderTraking()
            ],
          )
        ),
      ),
    );
  }
}

Widget _productItem({ int? index}) {
  return InkWell(
    onTap: () {
      // cubit.getProduct(products[index].id!);
      // MagicRouter.navigateAndPopUntilFirstPage(ProductView(index: index));
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                'https://png.pngtree.com/png-clipart/20210606/original/pngtree-3d-beauty-cosmetics-product-design-png-image_6391024.jpg',
                height: SizeConfig.defaultSize! * 10,
              ),
            ),
            const HorizontalSpace(value: 1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'name',
                    maxLines: 2,
                  ),
                  const VerticalSpace(value: 0.5),
                  Text(
                    '${LocaleKeys.quantity.tr()} : 2',
                    style: TextStyle(fontSize: SizeConfig.defaultSize),
                  ),
                  const VerticalSpace(value: 0.5),
                  Row(
                    children: [
                      Text('${LocaleKeys.item_price.tr()} : '),
                      Text(
                        '100',
                        style:
                            TextStyle(fontSize: SizeConfig.defaultSize! * 1.30),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
