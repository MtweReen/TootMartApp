import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';

import '../../detail/product_detail.dart';

class SearchResultBody extends StatefulWidget {
  const SearchResultBody({Key? key}) : super(key: key);

  @override
  State<SearchResultBody> createState() => _SearchResultBodyState();
}

class _SearchResultBodyState extends State<SearchResultBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! SearchProductsCubitLoadingState,
          builder: (context) => (HomeCubitCubit.get(context)
                  .searchModel!
                  .body!
                  .products!
                  .isNotEmpty)
              ? ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      CategoryCubit.get(context).getProductDetail(
                          id: HomeCubitCubit.get(context)
                              .searchModel!
                              .body!
                              .products![index]
                              .id!);
                           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailScreen()));     
                    },
                    leading: CircleAvatar(
                      backgroundColor: kMainColor,
                      radius: MediaQuery.of(context).size.width * 0.1,
                      backgroundImage: NetworkImage(HomeCubitCubit.get(context)
                          .searchModel!
                          .body!
                          .products![index]
                          .image!),
                    ),
                    title: Text(
                      HomeCubitCubit.get(context)
                          .searchModel!
                          .body!
                          .products![index]
                          .title!,
                      style: headingStyle,
                    ),
                  ),
                  itemCount: HomeCubitCubit.get(context)
                      .searchModel!
                      .body!
                      .products!
                      .length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: kMainColor,
                  ),
                )
              : Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                child: Center(
                    child: Text(
                      translateString("no search result", "لا توجد نتائج للبحث"),
                      style: headingStyle.copyWith(
                          color: kMainColor, fontWeight: FontWeight.bold),
                    ),
                  ),
              ),
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
