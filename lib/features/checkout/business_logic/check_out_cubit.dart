// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/helper/functions/show_toast.dart';
import 'package:toot_mart/core/network/local/cache_helper.dart';
import 'package:toot_mart/data/model/order.dart';
import 'package:toot_mart/data/model/order_detail.dart';
import 'package:toot_mart/data/model/room_filter.dart';
import 'package:toot_mart/data/model/user_address.dart';
import 'package:toot_mart/features/checkout/presentation/componnent/payment_screen.dart';
import '../../../core/constants/constants.dart';
import '../../../core/network/end_points.dart';
import '../../../core/router/router.dart';
import '../../../data/model/area.dart';
import '../../layout/layout.dart';
import 'check_out_states.dart';

class CheckOutCubit extends Cubit<CheckOutStates> {
  CheckOutCubit() : super(CheckOutInitial());

  static CheckOutCubit get(context) => BlocProvider.of(context);

  int currentTimeLine = 0;

  void moveInTimeLine(int page) {
    if (page == 3) {
      currentTimeLine = 0;
      emit(MoveInTimeLineState());
    } else {
      currentTimeLine = page;
      emit(MoveInTimeLineState());
    }
  }

  AreasModel? areasModel;

  Future<AreasModel>? getAreas() async {
    emit(GetAreasLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + GET_AREA,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        areasModel = AreasModel.fromJson(response.data);
        emit(GetAreasSuccessState());
        return areasModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetAreasErrorState(e.toString()));
    }
    return areasModel!;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////

  AreaFilterResult? areaFilterResult;
  bool isfilterring = false;

  Future<AreaFilterResult>? getFilterArea({required int areaId}) async {
    emit(GetAreasFilterLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + FILTER_ROOM + "$areaId",
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        isfilterring = true;
        areaFilterResult = AreaFilterResult.fromJson(response.data);
        emit(GetAreasFilterSuccessState());
        return areaFilterResult!;
      }
    } catch (e) {
      isfilterring = false;
      print(e.toString());
      emit(GetAreasFilterErrorState(e.toString()));
    }
    return areaFilterResult!;
  }

////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addUserAddress(
      {required String address, required int areaId}) async {
    emit(AddUserAddressLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + ADD_ADDRESS,
        data: {
          "area_id": areaId,
          "address": address,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        emit(AddUserAddressSuccessState());
      }
    } catch (e) {
      print(e.toString());
      emit(AddUserAddressErrorState(e.toString()));
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////

  UserAddressModel? userAddressModel;

  Future<UserAddressModel>? getUserAddress() async {
    emit(GetUserAddressLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + GETUSERADDRESS,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        userAddressModel = UserAddressModel.fromJson(response.data);
        emit(AddUserAddressSuccessState());
        return userAddressModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetUserAddressErrorState(e.toString()));
    }
    return userAddressModel!;
  }

  ////////////////////////////////////////////////////////////////////////////

  Future<void> createOrder() async {
    emit(CreateOrderLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + POST_CHECK_OUT,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
        data: {
          "shipping_id": prefs.getInt("shipping")!.toInt(),
          "user_address_id": prefs.getInt("address_id")!.toInt(),
          "payment_type": prefs.getInt("payment_type") ?? 1,
          "coupon": prefs.getString("coupon") ?? "",
          "total": prefs.getString("total").toString(),
        },
      );
      if (response.statusCode == 200) {
        if (CasheHelper.getData(key: 'payment_type') == 1) {
          MagicRouter.navigateTo(const LayoutScreen(index: 0));
        } else {
          MagicRouter.navigateTo(PaymentScreen(
            url: response.data.toString(),
          ));
        }
        CasheHelper.removeData(key: 'payment_type');
        showToast(msg: response.data["message"], state: ToastStates.SUCCESS);
      }
    } catch (e) {
      print(e.toString());
      emit(CreateOrderErrorState(e.toString()));
    }
  }

  ///////////////////////////////////////////////////////////////////////////////

  OrderModel? orderModel;

  Future<OrderModel>? getOrders() async {
    emit(GetOrderDetailLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + ORDERS,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        orderModel = OrderModel.fromJson(response.data);
        emit(GetOrderDetailSuccessState());
        return orderModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetOrderDetailErrorState(e.toString()));
    }
    return orderModel!;
  }

  //////////////////////////////////////////////////////////////////////

  SingleOrderModel? singleOrderModel;

  Future<SingleOrderModel>? getOrderDetail(
      {required int orderId, required context}) async {
    emit(GetOrderDetailLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + ORDER_DETAIL + "$orderId",
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        singleOrderModel = SingleOrderModel.fromJson(response.data);
        emit(GetOrderDetailSuccessState());
        return singleOrderModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetOrderDetailLoadingState());
      try {} catch (e) {
        print(e.toString());
        emit(GetOrderDetailErrorState(e.toString()));
      }
    }
    return singleOrderModel!;
  }

  Future<void> refundOrder({required String orderId}) async {
    emit(RefundOrdersLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + "orders/$orderId",
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        showToast(
            msg: translateString(
                "your refund request has been sent successfully",
                "تم إرسال طلبك بنجاح"),
            state: ToastStates.SUCCESS);
      }
    } catch (e) {
      showToast(
          msg: translateString("there is error , please try again later",
              "حدث خطأ الرجاء المحاولة ف وقت لاحق "),
          state: ToastStates.ERROR);
      print(e.toString());
      emit(RefundOrdersErrorState(e.toString()));
    }
  }
}
