import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';

import '../../core/constants/colors.dart';
import 'componnent/body.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BlocConsumer<HomeCubitCubit, HomeCubitState>(
            listener: (context, state) {
              if (state is FavouriteCubitSuccessState) {
                HomeCubitCubit.get(context).isFavourite[
                    CategoryCubit.get(context)
                        .productDetailModel!
                        .body!
                        .products!
                        .id!] = true;
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (prefs.getBool("is_login") == true) {
                    HomeCubitCubit.get(context).addtoFavourites(
                        productId: CategoryCubit.get(context)
                            .productDetailModel!
                            .body!
                            .products!
                            .id!);
                  } else {
                    Fluttertoast.showToast(
                        msg: translateString(
                            "you must login first", "يجب تسجيل الدخول اولا "),
                        backgroundColor: colorRed,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER);
                  }
                },
                icon: (HomeCubitCubit.get(context).isFavourite[
                            CategoryCubit.get(context)
                                .productDetailModel!
                                .body!
                                .products!
                                .id!] !=
                        true)
                    ? const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black87,
                      )
                    : Icon(
                        Icons.favorite,
                        color: colorRed,
                      ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          const ProductDetailBody(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is AddtoCartSuccessState) {
                  CartCubit.get(context).getcart();
                  Fluttertoast.showToast(
                      msg: translateString("product added to cart successfully",
                          "تم اضافة المنتج الي عربة التسوق"),
                      backgroundColor: colordeepGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white);
                }
              },
              builder: (context, state) {
                return (state is AddtoCartSuccessState) ?CustomGeneralButton(
                  text: translateString("Add to cart", "إضافة الي عربة التسوق"),
                  onTap: () {
                    CartCubit.get(context).addtocart(
                        productId: CategoryCubit.get(context)
                            .productDetailModel!
                            .body!
                            .products!
                            .id!);
                  },
                ):const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
