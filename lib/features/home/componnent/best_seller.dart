import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/all_products/all_products.dart';
import '../../../core/widgets/product_item.dart';

class BestSellerHome extends StatefulWidget {
  const BestSellerHome({
    Key? key,
    // required this.itemCount,
    required this.isScrollable,
  }) : super(key: key);
  // final int itemCount;
  final bool isScrollable;

  @override
  State<BestSellerHome> createState() => _BestSellerHomeState();
}

class _BestSellerHomeState extends State<BestSellerHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 15,
              mainAxisSpacing: 3,
            ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: HomeCubitCubit.get(context)
                .homeModel!
                .body!
                .categoriesMostSales!
                .length,
            itemBuilder: ((ctx, index) {
              return ProductItem(
                name: HomeCubitCubit.get(context)
                    .homeModel!
                    .body!
                    .categoriesMostSales![index]
                    .title!,
                image: HomeCubitCubit.get(context)
                    .homeModel!
                    .body!
                    .categoriesMostSales![index]
                    .image!,
                index: index,
                press: () {
                  CategoryCubit.get(context).getSubsCategory(
                      id: HomeCubitCubit.get(context)
                          .homeModel!
                          .body!
                          .categoriesMostSales![index]
                          .id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllProducts(),
                      ));
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
