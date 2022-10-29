import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/core/widgets/favourite_button.dart';
import 'package:toot_mart/features/layout/layout.dart';

import '../../core/constants/colors.dart';
import 'componnent/body.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productImage;
  const ProductDetailScreen({Key? key, required this.productImage})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    if (prefs.getBool("is_login") == true) {
      HomeCubitCubit.get(context).getFavourites();
      CartCubit.get(context).getcart();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ProductDetailLoadingState,
          fallback: (context) => Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          ),
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 3,
              backgroundColor: Colors.white,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: Text(
                translateString("product detail", "تفاصيل المنتج"),
                style: headingStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LayoutScreen(
                                index: 2,
                              )),
                      (route) => false),
                  child: Image.asset(
                    "asset/images/cart.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                FavouriteButton(
                    productId: CategoryCubit.get(context)
                        .productDetailModel!
                        .body!
                        .products!
                        .id!),
              ],
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ProductDetailBody(
                  productImage: widget.productImage,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is AddtoCartSuccessState) {
                        CartCubit.get(context).getcart();
                        Fluttertoast.showToast(
                            msg: translateString(
                                "product added to cart successfully",
                                "تم اضافة المنتج الي عربة التسوق"),
                            backgroundColor: colordeepGreen,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.white);
                      }
                    },
                    builder: (context, state) {
                      return (CartCubit.get(context).isinCart[
                                  CategoryCubit.get(context)
                                      .productDetailModel!
                                      .body!
                                      .products!
                                      .id!] !=
                              true)
                          ? CustomGeneralButton(
                              text: translateString(
                                  "Add to cart", "إضافة الي عربة التسوق"),
                              onTap: () {
                                if (prefs.getBool("is_login") == true) {
                                  if (CategoryCubit.get(context)
                                          .productDetailModel!
                                          .body!
                                          .products!
                                          .stock !=
                                      "0") {
                                    CartCubit.get(context).addtocart(
                                        productId: CategoryCubit.get(context)
                                            .productDetailModel!
                                            .body!
                                            .products!
                                            .id!,
                                        quantity: ProductDetailBody.counter);
                                  } else if (CategoryCubit.get(context)
                                          .productDetailModel!
                                          .body!
                                          .products!
                                          .stock ==
                                      "0") {
                                    Fluttertoast.showToast(
                                        msg: translateString(
                                            "product is unavailable",
                                            "المنتج غير متوفر حاليا "),
                                        backgroundColor: colorRed,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        textColor: Colors.white);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: translateString(
                                          "you must Login first ",
                                          "يجب تسجيل الدخول اولا "),
                                      backgroundColor: colorRed,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      textColor: Colors.white);
                                }
                              },
                            )
                          : const SizedBox();
                    },
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
