import 'package:flutter/material.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/products_grid_view.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/category/componnent/slider.dart';
import 'package:toot_mart/features/subCategory/sub_categrory.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.03,
          vertical: SizeConfig.screenHeight! * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(
            label: "",
            hint: LocaleKeys.search_for_products.tr(),
            prefix: Image.asset("asset/images/search.png", width: 20, height: 20,),
          ),
          const VerticalSpace(value: 2),
          const CategorySlider(),
          const VerticalSpace(value: 4),
          Text(
            translateString("formations", "تشكيلات"),
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: colordeepGrey,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
          const VerticalSpace(value: 2),
          ProductsGridView(
            itemCount: 8,
            isScrollable: false,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SubCategoryScreen())),
          ),
        ],
      ),
    );
  }
}
