// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/data/model/cart.dart';
import '../../core/constants/constants.dart';
import '../../data/model/add_to_cart.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  AddtoCartModel? addtoCartModel;
  Future<AddtoCartModel>? addtocart({required int productId}) async {
    emit(AddtoCartLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + ADD_TO_CART,
        data: {"product_id": productId.toString()},
        options: Options(
          headers: {
            "Authorization": "Bearer ${kUser!.body!.accessToken!}",
            "Accept-Language": prefs.get("lang") ?? "ar",
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        addtoCartModel = AddtoCartModel.fromJson(response.data);
        emit(AddtoCartSuccessState());
        return addtoCartModel!;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: translateString(response.data['message'].toString(),
                "تم اضافة المنتج الي عربة التسوق"),
            backgroundColor: colorRed,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: translateString(
              "already in your cart!", "المنتج موجود بالفعل في عربة التسوق"),
          backgroundColor: colorRed,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
      print(e.toString());
      emit(AddtoCartErrorState(e.toString()));
    }
    return addtoCartModel!;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////

  CartModel? cartModel;
  Future<CartModel>? getcart() async {
    emit(GetCartLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + CART,
        options: Options(
          headers: {
            "Authorization": "Bearer ${kUser!.body!.accessToken!}",
            "Accept-Language": prefs.get("lang") ?? "ar",
          },
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        cartModel = CartModel.fromJson(response.data);
        emit(GetCartSuccessState());
        return cartModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetCartErrorState(e.toString()));
    }
    return cartModel!;
  }
}
