// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/all_products/component/product_card.dart';

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
      listener: (context, state) {
        if (state is FavouriteCubitSuccessState) {
        //  if(HomeCubitCubit.get(context).favouriteModel!.body!.products!.isNotEmpty){
        //    for (var element
        //       in HomeCubitCubit.get(context).favouriteModel!.body!.products!) {
        //     HomeCubitCubit.get(context).isFavourite[element.id!] = true;
        //   }
        //  }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => (HomeCubitCubit.get(context)
                  .favouriteModel!
                  .body!
                  .products!
                  .isNotEmpty)
              ? GridView.builder(
                padding:  const EdgeInsets.all(10),
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
                    imge: HomeCubitCubit.get(context)
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
                    beforePrice:(HomeCubitCubit.get(context)
                        .favouriteModel!
                        .body!
                        .products![index]
                        .priceBefore != null)? HomeCubitCubit.get(context)
                        .favouriteModel!
                        .body!
                        .products![index]
                        .priceBefore!.toString() : 0,
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
          condition: state is! FavouriteCubitLoadingState,
          fallback: (BuildContext context) => Padding(
             padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
            child: Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
