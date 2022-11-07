import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/all_products/component/filter_row.dart';

import 'component/body.dart';

class AllProducts extends StatefulWidget {
  final int categoryId;
  const AllProducts({ Key? key, required this.categoryId }) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "تشكيلات", context: context, press: (){
        setState(() {
          filteringData = false;
        });
        Navigator.pop(context);
      }),
      body:  AllProductBody(categoryId: widget.categoryId,),
    );
  }
}