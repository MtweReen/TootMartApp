import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';

import 'componnent/body.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          translateString("product detail", "تفاصيل المنتج"),
          style: headingStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width * 0.04),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          const ProductDetailBody(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: CustomGeneralButton(
              text: translateString("Add to cart", "إضافة الي عربة التسوق"),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
