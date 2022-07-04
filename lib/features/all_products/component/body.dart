import 'package:flutter/material.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/all_products/component/filter_row.dart';
import 'package:toot_mart/features/all_products/component/product_grid.dart';

class AllProductBody extends StatefulWidget {
  const AllProductBody({Key? key}) : super(key: key);

  @override
  State<AllProductBody> createState() => _AllProductBodyState();
}

class _AllProductBodyState extends State<AllProductBody> {
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
        children:  [
         const FilterProducts(),
         const VerticalSpace(value: 4),
          ProductGridData(fromfav: false,),
        ],
      ),
    );
  }
}
