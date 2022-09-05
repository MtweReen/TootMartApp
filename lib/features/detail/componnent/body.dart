import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/home/componnent/slider.dart';

import '../../../core/utiles/size_config.dart';
import '../../../core/widgets/custom_quantity.dart';
import 'similar_product.dart';

class ProductDetailBody extends StatefulWidget {
  final String productImage;
  static int counter = 1;
  const ProductDetailBody({Key? key, required this.productImage})
      : super(key: key);

  @override
  State<ProductDetailBody> createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ProductDetailLoadingState,
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          ),
          builder: (context) => SingleChildScrollView(
         
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (CategoryCubit.get(context)
                        .productDetailModel!
                        .body!
                        .products!
                        .images!
                        .isNotEmpty)
                    ? HomeSlider(
                        images: CategoryCubit.get(context)
                            .productDetailModel!
                            .body!
                            .products!
                            .images!,
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: customCachedNetworkImage(
                            url: widget.productImage,
                            context: context,
                            fit: BoxFit.contain),
                      ),
                const VerticalSpace(value: 3),
                Text(
                  "شحن مجانى عند تسوقك ب 350 رس واكثر",
                  style: headingStyle,
                ),
                Padding(
                     padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.03,
                vertical: SizeConfig.screenHeight! * 0.03),
                  child: Column(
                    children: [
                      const VerticalSpace(value: 2),
                      Text(
                        CategoryCubit.get(context)
                            .productDetailModel!
                            .body!
                            .products!
                            .title!,
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenWidth! * 0.05),
                      ),
                      const VerticalSpace(value: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translateString("Quantity", "الكمية"),
                            style: headingStyle,
                          ),
                          Row(
                            children: [
                              CustomQuantity(
                                child: Image.asset(
                                  'asset/images/mince.png',
                                ),
                                onTap: () {
                                  if (ProductDetailBody.counter == 1) {
                                    setState(() {
                                      ProductDetailBody.counter =
                                          ProductDetailBody.counter;
                                    });
                                  } else {
                                    setState(() {
                                      ProductDetailBody.counter--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${ProductDetailBody.counter}"),
                              ),
                              CustomQuantity(
                                child: Image.asset(
                                  'asset/images/plus.png',
                                ),
                                onTap: () {
                                  if (ProductDetailBody.counter <
                                      num.parse(CategoryCubit.get(context)
                                          .productDetailModel!
                                          .body!
                                          .products!
                                          .stock!)) {
                                    setState(() {
                                      ProductDetailBody.counter++;
                                    });
                                  } else if (ProductDetailBody.counter ==
                                      num.parse(CategoryCubit.get(context)
                                          .productDetailModel!
                                          .body!
                                          .products!
                                          .stock!)) {
                                    setState(() {
                                      ProductDetailBody.counter =
                                          ProductDetailBody.counter;
                                      Fluttertoast.showToast(
                                          msg: translateString(
                                              "available quantity is only ${CategoryCubit.get(context).productDetailModel!.body!.products!.stock!}",
                                              "الكميه المتاحة فقط ${CategoryCubit.get(context).productDetailModel!.body!.products!.stock!}"),
                                          backgroundColor: colorRed,
                                          textColor: Colors.white,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const VerticalSpace(value: 2),
                      (CategoryCubit.get(context)
                                  .productDetailModel!
                                  .body!
                                  .products!
                                  .stock !=
                              "0")
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (CategoryCubit.get(context)
                                            .productDetailModel!
                                            .body!
                                            .products!
                                            .stock !=
                                        "0")
                                    ? Row(
                                        children: [
                                          CircleAvatar(
                                            radius: SizeConfig.screenWidth! * 0.02,
                                            backgroundColor: colordeepGreen,
                                          ),
                                          const HorizontalSpace(value: 1),
                                          Text(
                                            translateString("available", "متوفر"),
                                            style: headingStyle,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                Text(
                                  "${CategoryCubit.get(context).productDetailModel!.body!.products!.price} R.S",
                                  style: headingStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: kMainColor,
                                      fontSize: SizeConfig.screenWidth! * 0.05),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                translateString("product is unavailable",
                                    "المنتج غير متوفر حاليا "),
                                style: headingStyle.copyWith(
                                    color: colorRed, fontWeight: FontWeight.bold),
                              ),
                            ),
                      const VerticalSpace(value: 2),
                      Divider(
                        color: colorGrey,
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        translateString("product description", "وصف المنتج"),
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenWidth! * 0.05),
                      ),
                      const VerticalSpace(value: 2),
                      Text(
                        CategoryCubit.get(context)
                            .productDetailModel!
                            .body!
                            .products!
                            .description!,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.screenWidth! * 0.04,
                            color: colorGrey),
                      ),
                      const VerticalSpace(value: 3),
                      Text(
                        translateString("similar products", "المنتجات المشابهة"),
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenWidth! * 0.05),
                      ),
                      const VerticalSpace(value: 2),
                      Divider(
                        color: colorGrey,
                      ),
                      const VerticalSpace(value: 2),
                      const SimilarProduct(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
