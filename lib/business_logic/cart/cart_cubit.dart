// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/helper/functions/show_toast.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/core/network/remote/dio_helper.dart';
import 'package:toot_mart/data/model/cart.dart';
import '../../core/constants/constants.dart';
import '../../data/model/add_to_cart.dart';

part 'cart_state.dart';

// ignore: constant_identifier_names
enum CartRequestStates { PLUS, MINUS, DELETE }

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  AddtoCartModel? addtoCartModel;
  Future<AddtoCartModel>? addtocart(
      {required int productId, required int quantity}) async {
    emit(AddtoCartLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + ADD_TO_CART,
        data: {"product_id": productId, 'quantity': quantity},
        options: Options(
          headers: {
            "Authorization": "Bearer ${prefs.getString('token').toString()}",
            "Accept-Language": prefs.get("lang") ?? "ar",
          },
        ),
      );
      if (response.statusCode == 200) {
        addtoCartModel = AddtoCartModel.fromJson(response.data);
        emit(AddtoCartSuccessState());
        return addtoCartModel!;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: response.data['message'].toString(),
            backgroundColor: colorRed,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white);
          emit(AddtoCartSuccessState());   
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: translateString("there is error , please try again later ...",
              "حدث خطأ ما الرجاء المحاولة مرة اخري"),
          backgroundColor: colorRed,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
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
            "Authorization": "Bearer ${prefs.getString('token').toString()}",
            "Accept-Language": prefs.get("lang") ?? "ar",
          },
        ),
      );

      if (response.statusCode == 200) {
        cartModel = CartModel.fromJson(response.data);
        emit(GetCartSuccessState());
        return cartModel!;
      }
    } catch (e) {
      emit(GetCartErrorState(e.toString()));
    }
    return cartModel!;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  String? action;
  Future<void>? cartUpdate(
      {required CartRequestStates cartRequestStates,
      required int cartId}) async {
    try {
      switch (cartRequestStates) {
        case CartRequestStates.PLUS:
          action = 'plus';
          break;
        case CartRequestStates.MINUS:
          action = 'minus';
          break;
        case CartRequestStates.DELETE:
          action = 'delete';
          break;
      }
      Response response = await DioHelper.postLoggedUser(
          url: CONTROL_CART_ITEM + '?action=' + action!,
          
          data: {'cart_id': cartId});
      if (response.statusCode == 200) {
        getcart();
      }
    } catch (e) {
      emit(UpdateCartErrorState());
    }
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void>? ApplyCoupon(
      {required double total, required String code}) async {
    try {
      Response response =
          await DioHelper.postLoggedUser(url: APPLY_COUPON, data: {
        'total': total,
        'code': code,
      });
      if (response.statusCode == 200) {
        showToast(
            msg: response.data["message"].toString(),
            state: ToastStates.SUCCESS);
        prefs.setString("coupon", code);
        prefs.setString(
            "coupon_value", response.data["body"]["coupon_value"].toString());
        prefs.setString(
            "coupon_total", response.data["body"]["total"].toString());
        emit(CouponAppliedSuccessState());
      } else if (response.statusCode == 400) {
        showToast(
            msg: response.data["message"].toString(), state: ToastStates.ERROR);
      }
    } catch (e) {
      emit(CouponAppliedErrorState());
    }
  } //////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void>? RemoveCoupon(
      {required double total, required String code}) async {
    try {
      Response response =
          await DioHelper.postLoggedUser(url: CANCEL_COUPON, data: {
        'total': total,
        'code': code,
      });

      if (response.statusCode == 200) {
        showToast(msg: 'تم حزف الكوبون', state: ToastStates.SUCCESS);
        emit(CouponRemovedSuccessState());
      } else if (response.statusCode == 400) {
        showToast(msg: 'هذا الكوبون غير متاح', state: ToastStates.ERROR);
      }
    } catch (e) {
      emit(CouponRemovedErrorState());
    }
  }
}
