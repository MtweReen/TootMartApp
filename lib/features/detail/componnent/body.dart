import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/home/componnent/slider.dart';

import '../../../core/utiles/size_config.dart';
import 'similar_product.dart';

class ProductDetailBody extends StatefulWidget {
  const ProductDetailBody({Key? key}) : super(key: key);

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.03,
          vertical: SizeConfig.screenHeight! * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeSlider(),
          const VerticalSpace(value: 3),
          Text(
            "شحن مجانى عند تسوقك ب 350 رس واكثر",
            style: headingStyle,
          ),
          const VerticalSpace(value: 2),
          Text(
            "فازه",
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
          const VerticalSpace(value: 3),
          Row(
            children: [
              Text(
                translateString("Quantity", "الكمية"),
                style: headingStyle,
              ),
            ],
          ),
          const VerticalSpace(value: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: SizeConfig.screenWidth! * 0.02,
                    backgroundColor: colordeepGreen,
                  ),
                  const HorizontalSpace(value: 1),
                  Text(
                    translateString("available", "متوفر"),
                    style: headingStyle,
                  ),
                ],
              ),

              Text(
            "150 R.S",
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: kMainColor,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
            ],
          ),
          const VerticalSpace(value: 2),
          Divider(
            color: colorGrey,
          ),
          const VerticalSpace(value: 2),
          Text(
            translateString("product description", "وصف المنتج"),
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
          const VerticalSpace(value: 2),
          Text(
            "فاظه ورد شفافه مصنوعه من خامه الاكريليك الشفافه بيها نباتات رقيقه و جميله و ارضيه صغيره من الصخوره الملونه بلون البحر الفاظه تتميزبرقتها و مناسبه للديكور اضافه رقيقه و مبهجه لديكور منزلك او حتي مكتبك هديه رائعه لمن تحبون",
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.screenWidth! * 0.04,
                color: colorGrey),
          ),
          const VerticalSpace(value: 3),
          Text(
            translateString("similar products", "المنتجات المشابهة"),
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
          const VerticalSpace(value: 2),
          Divider(
            color: colorGrey,
          ),
          const VerticalSpace(value: 2),
          const SimilarProduct(),
        ],
      ),
    );
  }
}
