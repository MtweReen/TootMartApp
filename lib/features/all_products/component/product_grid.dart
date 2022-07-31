// ignore_for_file: must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/all_products/component/product_card.dart';

import '../../../business_logic/category/category_cubit.dart';
import '../../../core/constants/constants.dart';

class ProductGridData extends StatelessWidget {
  bool? fromfav;
  ProductGridData({Key? key, this.fromfav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => (CategoryCubit.get(context)
                  .subcategoryModel!
                  .body!
                  .products!
                  .isNotEmpty)
              ? GridView.builder(
                  itemCount: CategoryCubit.get(context)
                      .subcategoryModel!
                      .body!
                      .products!
                      .length,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => ProductCardData(
                    beforePrice: double.parse(CategoryCubit.get(context)
                        .subcategoryModel!
                        .body!
                        .products![index]
                        .priceBefore.toString()),
                    fromfav: fromfav!,
                    id: CategoryCubit.get(context)
                        .subcategoryModel!
                        .body!
                        .products![index]
                        .id!,
                    imge: CategoryCubit.get(context)
                        .subcategoryModel!
                        .body!
                        .products![index]
                        .image!,
                    name: CategoryCubit.get(context)
                        .subcategoryModel!
                        .body!
                        .products![index]
                        .title!,
                    price: CategoryCubit.get(context)
                        .subcategoryModel!
                        .body!
                        .products![index]
                        .price
                        .toString(),
                  ),
                )
              : Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                child: Center(
                    child: Text(
                      translateString("No products here", "لا توجد منتجات"),
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ),
          condition: state is! SubCategoryLoadingState,
          fallback: (BuildContext context) => Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          ),
        );
      },
    );
  }
}
