import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_out_states.dart';

class CheckOutCubit extends Cubit<CheckOutStates> {
  CheckOutCubit() : super(CheckOutInitial());

  static CheckOutCubit get(context) => BlocProvider.of(context);

  int currentTimeLine = 0;

  void moveInTimeLine(int page) {
    currentTimeLine = page;
    emit(MoveInTimeLineState());
  }
// double shippingPrice = 0;
// int? shippingId;
// CheckOutModel? checkOutModel;
// double? totalWithShipping;
//
// List<CheckOutModel>? getCheckOut() {
//   emit(CheckOutLoadingState());
//   CeckOutRepositoryImpl().getCheckOut().then((value) {
//     if (value != []) {
//       checkOutModel = value.getOrElse(() => CheckOutModel.fromJson({}));
//       print(checkOutModel!);
//       if (checkOutModel!.data!.cart!.subtotal != null) {
//         CasheHelper.saveData(
//             key: 'totalWithShippingCheckOut',
//             value: checkOutModel!.data!.cart!.subtotal);
//       }
//       emit(CheckOutSuccessState());
//     }
//   });
//   return null;
// }
//
// String? postCheckOutMessage;
//
// Future<void>? postCheckOut({
//   required int shipping_id,
//   required String country,
//   required String city,
//   required String address,
//   required String phone,
//   required String amount,
//   required String code,
//   required int payment_type,
// }) {
//   emit(PostCheckOutLoadingState());
//   CeckOutRepositoryImpl()
//       .postCheckOut(
//     shipping_id: shipping_id,
//     country: country,
//     city: city,
//     address: address,
//     phone: phone,
//     payment_type: payment_type,
//     amount: amount,
//     code: code,
//   )
//       .then((value) {
//     if (value != []) {
//       CasheHelper.removeData(key: 'coupon');
//       postCheckOutMessage = value.getOrElse(() => '');
//     }
//     getCheckOut();
//
//     emit(PostCheckOutSuccessState());
//   });
//   return null;
// }
//
// CouponModel? couponModel;
//
// List<CouponModel>? checkCouponValidation({
//   required String coupon,
//   required int subTotal,
// }) {
//   emit(CouponValidateLoadingState());
//   CeckOutRepositoryImpl()
//       .checkCouponValidation(coupon, subTotal)
//       .then((value) {
//     if (value != []) {
//       couponModel = value.getOrElse(() => CouponModel.fromJson({}));
//       if (couponModel!.status == 1) {
//         if (couponModel!.couponValue != null) {
//           CasheHelper.saveData(key: 'coupon', value: coupon);
//         }
//         print(CasheHelper.getData(key: 'coupon').toString());
//         totalWithShipping = double.parse(
//                 CasheHelper.getData(key: 'totalWithShippingCheckOut')
//                     .toString()) -
//             double.parse(couponModel!.couponValue.toString());
//         CasheHelper.saveData(
//             key: 'totalWithShippingCheckOut', value: totalWithShipping);
//         showToast(msg: 'تم تطبيق الكوبون بنجاح', state: ToastStates.SUCCESS);
//         emit(CouponValidateSuccessState());
//       } else {
//         showToast(msg: 'هذا الكوبون غير متاح', state: ToastStates.ERROR);
//         emit(CouponValidateErrorState());
//       }
//     }
//   });
//   return null;
// }
//
// String? value;
//
// void changeDropdownValue(String value) {
//   this.value = value;
//   emit(DropDownChangeState());
// }
}
