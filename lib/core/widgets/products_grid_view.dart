import 'package:flutter/material.dart';
import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView(
      {Key? key,
      required this.itemCount,
      required this.isScrollable,
      this.press})
      : super(key: key);
  final int itemCount;
  final bool isScrollable;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 15,
        mainAxisSpacing: 3,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      itemBuilder: ((ctx, index) {
        return ProductItem(
          index: index,
          press: press,
        );
      }),
    );
  }
}
