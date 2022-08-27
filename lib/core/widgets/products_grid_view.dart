import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import '../../business_logic/category/category_cubit.dart';
import '../../features/subCategory/sub_categrory.dart';
import 'product_item.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({
    Key? key,
    // required this.itemCount,
    required this.isScrollable,
  }) : super(key: key);
  // final int itemCount;
  final bool isScrollable;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 15,
              mainAxisSpacing: 3,
            ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: CategoryCubit.get(context)
                .categoryModel!
                .body!
                .categories!
                .length,
            itemBuilder: ((ctx, index) {
              return ProductItem(
                name: CategoryCubit.get(context)
                    .categoryModel!
                    .body!
                    .categories![index]
                    .title!,
                image: CategoryCubit.get(context)
                    .categoryModel!
                    .body!
                    .categories![index]
                    .image!,
                index: index,
                press: () {
                  CategoryCubit.get(context).getSubsCategory(
                      id: CategoryCubit.get(context)
                          .categoryModel!
                          .body!
                          .categories![index]
                          .id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubCategoryScreen(
                                id: CategoryCubit.get(context)
                                    .categoryModel!
                                    .body!
                                    .categories![index]
                                    .id!,
                                image: CategoryCubit.get(context)
                                    .categoryModel!
                                    .body!
                                    .categories![index]
                                    .image!,
                                name: CategoryCubit.get(context)
                                    .categoryModel!
                                    .body!
                                    .categories![index]
                                    .title!,
                              )));
                },
              );
            }),
          ),
          condition: state is! CategoryLoadingState,
          fallback: (BuildContext context) => Center(
            child: CircularProgressIndicator(color: kMainColor),
          ),
        );
      },
    );
  }
}
