// ignore_for_file: must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/favourite_button.dart';
import 'package:toot_mart/features/all_products/component/filter_row.dart';

import '../../detail/product_detail.dart';

class ProductCardData extends StatelessWidget {
  bool? fromfav;
  final String name;
  final String imge;
  final String price;
  var beforePrice;
  final int id;
  ProductCardData(
      {Key? key,
      this.fromfav,
      required this.name,
      required this.imge,
      required this.price,
      required this.id,
      required this.beforePrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorLightGrey),
      ),
      child: InkWell(
        onTap: () {
          filteringData = false;
          CategoryCubit.get(context).getProductDetail(id: id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailScreen()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: w * 0.45,
                  height: h * 0.25,
                  color: Colors.white,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: customCachedNetworkImage(
                          url: imge, fit: BoxFit.cover, context: context)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.02, vertical: h * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     FavouriteButton(productId: id,),
                      (beforePrice != 0)
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.02, vertical: h * 0.003),
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  translateString("discount", "تخفيض"),
                                  style: headingStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * 0.04),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: h * 0.015, left: w * 0.02, right: w * 0.02),
              child: SizedBox(
                width: w * 0.45,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: h * 0.07, maxWidth: w * 0.4),
                      child: Text(name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: headingStyle.copyWith(
                              color: colordeepGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: w * 0.04)),
                    ),
                    SizedBox(
                      height: h * 0.002,
                    ),
                    SizedBox(
                      height: h * 0.005,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$price r.s",
                                style: headingStyle.copyWith(
                                    color: kMainColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: w * 0.04),
                              ),
                            ],
                          ),
                        ),
                        (beforePrice != 0)
                            ? Text("$beforePrice R.S",
                                style: headingStyle.copyWith(
                                    color: colorGrey,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500,
                                    fontSize: w * 0.04,
                                    decorationColor: colordeepGrey))
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
