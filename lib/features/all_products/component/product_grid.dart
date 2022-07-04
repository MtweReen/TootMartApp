import 'package:flutter/material.dart';
import 'package:toot_mart/features/all_products/component/product_card.dart';

class ProductGridData extends StatelessWidget {
  bool? fromfav;
   ProductGridData({Key? key, this.fromfav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) =>  ProductCardData(fromfav: fromfav!,),
    );
  }
}
