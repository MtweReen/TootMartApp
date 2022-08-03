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
  Map<int, bool> isinCart = {};
  Future<AddtoCartModel>? addtocart(
      {required int productId, required int quantity}) async {
    emit(AddtoCartLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + ADD_TO_CART,
        data: {"product_id": 1, 'quantity': 1},
        options: Options(
          headers: {
            "Authorization": "Bearer ${kUser!.body!.accessToken!}",
            "Accept-Language": prefs.get("lang") ?? "ar",
          },
        ),
      );
      if (response.statusCode == 200) {
        isinCart[productId] = true;
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
      print(response.data);
      if (response.statusCode == 200) {
        print('askldjfbasdkljbfalsdf');
        
        print(response.data);
        cartModel = CartModel.fromJson(response.data);
        for (var element in cartModel!.body!.carts!) {
          isinCart[element.id!] = true;
          emit(GetCartSuccessState());
          
        }
        print(isinCart);
        emit(GetCartSuccessState());
        return cartModel!;
      }
    } catch (e) {
      print(e.toString());
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
          // query: {'action': action},
          data: {'cart_id': cartId});
      print(response.data);
      if (response.statusCode == 200) {
        getcart();
        print(response.data);
      }
    } catch (e) {
      print(e.toString());
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
      print(response.data);
      if (response.statusCode == 200) {
        showToast(msg: 'تم إضافة كوبون', state: ToastStates.SUCCESS);
        emit(CouponAppliedSuccessState());
        print(response.data);
      } else if (response.statusCode == 400) {
        showToast(msg: response.data["message"].toString(), state: ToastStates.ERROR);
      }
    } catch (e) {
      print(e.toString());
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
      print(response.data);
      if (response.statusCode == 200) {
        showToast(msg: 'تم حزف الكوبون', state: ToastStates.SUCCESS);
        emit(CouponRemovedSuccessState());
        print(response.data);
      } else if (response.statusCode == 400) {
        showToast(msg: 'هذا الكوبون غير متاح', state: ToastStates.ERROR);
      }
    } catch (e) {
      print(e.toString());
      emit(CouponRemovedErrorState());
    }
  }
}
