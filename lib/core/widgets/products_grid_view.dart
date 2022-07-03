import 'package:flutter/material.dart';
import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView(
      {Key? key, required this.itemCount, required this.isScrollable})
      : super(key: key);
  final int itemCount;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        itemBuilder: ((ctx, index) {
          return ProductItem(
            index: index,
          );
        }));
  }
}
