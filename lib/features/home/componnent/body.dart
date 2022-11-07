import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/home/componnent/search_result.dart';
import 'package:toot_mart/features/home/componnent/slider.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../business_logic/home/home_cubit_cubit.dart';
import 'best_seller.dart';
import 'category_list.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async =>
              await HomeCubitCubit.get(context).getHomeItems(),
          child: ConditionalBuilder(
            condition: HomeCubitCubit.get(context).homeModel != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
            builder: (BuildContext context) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.03,
                    vertical: SizeConfig.screenHeight! * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      label: "",
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          HomeCubitCubit.get(context)
                              .getSearchResult(keyword: value);
                          setState(() {
                            isSearching = true;
                          });
                        } else {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      onEditingComplete: () {},
                      onSaved: (value) {
                        if (value.isNotEmpty) {
                        } else {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      hint: LocaleKeys.search_for_products.tr(),
                      prefix: Image.asset(
                        "asset/images/search.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    (!isSearching)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpace(value: 2),
                              (HomeCubitCubit.get(context)
                                      .homeModel!
                                      .body!
                                      .images!
                                      .isNotEmpty)
                                  ? HomeSlider(
                                      images: HomeCubitCubit.get(context)
                                          .homeModel!
                                          .body!
                                          .images!,
                                    )
                                  : const SizedBox(),
                              const VerticalSpace(value: 2),
                              (HomeCubitCubit.get(context)
                                      .homeModel!
                                      .body!
                                      .categoriesParents!
                                      .isNotEmpty)
                                  ? CategoryList(
                                      categories: HomeCubitCubit.get(context)
                                          .homeModel!
                                          .body!
                                          .categoriesParents!,
                                    )
                                  : const SizedBox(),
                              const VerticalSpace(value: 4),
                              Text(
                                translateString("Best Selling Categories",
                                    "الفئات الأكثر مبيعا"),
                                style: headingStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colordeepGrey,
                                    fontSize: SizeConfig.screenWidth! * 0.05),
                              ),
                              const VerticalSpace(value: 4),
                              const BestSellerHome(
                                isScrollable: false,
                              ),
                            ],
                          )
                        : const SearchResultBody(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
