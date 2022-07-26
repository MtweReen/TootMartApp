import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/features/detail/product_detail.dart';

import '../../../business_logic/category/category_cubit.dart';
import '../../../core/widgets/product_item.dart';

class SimilarProduct extends StatefulWidget {
  const SimilarProduct({Key? key}) : super(key: key);

  @override
  State<SimilarProduct> createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: CategoryCubit.get(context)
              .productDetailModel!
              .body!
              .products!
              .similar!
              .length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 15,
            mainAxisSpacing: 3,
          ),
          itemBuilder: ((context, index) {
            return ProductItem(
              image: CategoryCubit.get(context)
                  .productDetailModel!
                  .body!
                  .products!
                  .similar![index]
                  .image!,
              name: CategoryCubit.get(context)
                  .productDetailModel!
                  .body!
                  .products!
                  .similar![index]
                  .title!,
              index: index,
              press: () {
                CategoryCubit.get(context).getProductDetail(
                    id: CategoryCubit.get(context)
                        .productDetailModel!
                        .body!
                        .products!
                        .similar![index]
                        .id!);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductDetailScreen()));
              },
            );
          }),
        );
      },
    );
  }
}
