import 'package:flutter/material.dart';

import '../../../core/widgets/product_item.dart';

class SimilarProduct extends StatefulWidget {
  const SimilarProduct({ Key? key }) : super(key: key);

  @override
  State<SimilarProduct> createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 15,
          mainAxisSpacing: 3,
        ),
       itemBuilder: ((context, index) {
        return ProductItem(
          index: index,
          press: (){},
        );
      }),
    );
  }
}