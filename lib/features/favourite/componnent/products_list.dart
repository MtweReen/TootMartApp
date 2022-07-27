// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/features/all_products/component/product_card.dart';

import '../../../business_logic/category/category_cubit.dart';

class FavouriteProductList extends StatefulWidget {
  bool? fromfav;
  FavouriteProductList({Key? key, this.fromfav}) : super(key: key);

  @override
  State<FavouriteProductList> createState() => _FavouriteProductListState();
}

class _FavouriteProductListState extends State<FavouriteProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => GridView.builder(
            itemCount: HomeCubitCubit.get(context)
                .favouriteModel!
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
              fromfav: widget.fromfav!,
              id: HomeCubitCubit.get(context)
                .favouriteModel!
                  .body!
                  .products![index]
                  .id!,
              imge:HomeCubitCubit.get(context)
                .favouriteModel!
                  .body!
                  .products![index]
                  .image!,
              name: HomeCubitCubit.get(context)
                .favouriteModel!
                  .body!
                  .products![index]
                  .title!,
              price: HomeCubitCubit.get(context)
                .favouriteModel!
                  .body!
                  .products![index]
                  .price
                  .toString(),
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
