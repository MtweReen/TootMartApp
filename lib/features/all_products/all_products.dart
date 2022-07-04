import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import 'component/body.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({ Key? key }) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "تشكيلات", context: context, press: ()=>Navigator.pop(context)),
      body:const  AllProductBody(),
    );
  }
}