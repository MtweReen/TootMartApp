import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/all_products/component/filter_row.dart';
import 'package:toot_mart/features/all_products/component/product_grid.dart';

import '../filter/filter_result.dart';

class AllProductBody extends StatefulWidget {
  final int categoryId;
  const AllProductBody({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<AllProductBody> createState() => _AllProductBodyState();
}

class _AllProductBodyState extends State<AllProductBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
         onRefresh: () async=> await CategoryCubit.get(context).getSubsCategory(id: widget.categoryId),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             FilterProducts(categoryId: widget.categoryId,),
            const VerticalSpace(value: 4),
            (filteringData)
                ? BlocConsumer<CategoryCubit, CategoryState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return FilterResultScreen(
                        categoryId: CategoryCubit.get(context)
                            .subcategoryModel!
                            .body!
                            .category!
                            .id!,
                      );
                    },
                  )
                : ProductGridData(
                    fromfav: false,
                    categoryId: widget.categoryId,
                  ),
          ],
        ),
      ),
    );
  }
}
