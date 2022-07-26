import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/data/model/subcategory.dart';
import 'package:toot_mart/features/subCategory/componnent/products.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utiles/size_config.dart';
import '../../../core/widgets/space_widget.dart';
import '../../all_products/all_products.dart';

class SubCategoryBody extends StatefulWidget {
  final String image;
  final String name;
  final int id;
  const SubCategoryBody(
      {Key? key, required this.image, required this.name, required this.id})
      : super(key: key);

  @override
  State<SubCategoryBody> createState() => _SubCategoryBodyState();
}

class _SubCategoryBodyState extends State<SubCategoryBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.3,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: headingStyle.copyWith(
                        fontSize: SizeConfig.screenWidth! * 0.05,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          // ..strokeWidth = 1
                          ..color = Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.03,
                vertical: SizeConfig.screenHeight! * 0.03),
            child: BlocConsumer<CategoryCubit, CategoryState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! SubCategoryLoadingState,
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  ),
                  builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const VerticalSpace(value: 2),
                              InkWell(
                                onTap: () {
                                  CategoryCubit.get(context).getSubsCategory(
                                      id: CategoryCubit.get(context)
                                          .subcategoryModel!
                                          .body!
                                          .subCategories![index]
                                          .id!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllProducts()));
                                },
                                child: Text(
                                  CategoryCubit.get(context)
                                      .subcategoryModel!
                                      .body!
                                      .subCategories![index]
                                      .title!,
                                  style: headingStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colordeepGrey,
                                      fontSize: SizeConfig.screenWidth! * 0.05),
                                ),
                              ),
                              const VerticalSpace(value: 2),
                              SubCategoryProducts(
                                products: CategoryCubit.get(context)
                                    .subcategoryModel!
                                    .body!
                                    .products!,
                              ),
                            ],
                          ),
                      separatorBuilder: (context, index) =>
                          const VerticalSpace(value: 2),
                      itemCount: CategoryCubit.get(context)
                          .subcategoryModel!
                          .body!
                          .subCategories!
                          .length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
