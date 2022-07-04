import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/products_grid_view.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/home/componnent/slider.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'category_list.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
          CustomTextFormField(label: "", hint: LocaleKeys.search_for_products.tr(), prefix: Icons.search_outlined,),
          const VerticalSpace(value: 2),
          const HomeSlider(),
           const VerticalSpace(value: 2),
          const CategoryList(),
          const VerticalSpace(value: 4),
          Text(
            translateString("Best Selling Categories", "الفئات الأكثر مبيعا"),
            style: headingStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: colordeepGrey,
                fontSize: SizeConfig.screenWidth! * 0.05),
          ),
          const VerticalSpace(value: 4),
          const ProductsGridView(itemCount: 8, isScrollable: false),
        ],
      ),
    );
  }
}
