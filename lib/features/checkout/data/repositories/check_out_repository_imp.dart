
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/end_points.dart';
import '../../../../core/network/remote/dio_helper.dart';
import '../../domain/repositories/check_out_repo.dart';

class CeckOutRepositoryImpl extends CheckOutRepo {
  // @override
  // Future<Either<Exception, CheckOutModel>> getCheckOut() async {
  //   try {
  //     var response = await DioHelper.getLoggedUserData(url: GET_CHECK_OUT);
  //
  //     CheckOutModel? checkOutModel;
  //     if (response.statusCode! < 500) {
  //       checkOutModel = CheckOutModel.fromJson(response.data);
  //     }
  //     return Right(checkOutModel!);
  //   } catch (error) {
  //     return Left(Exception(error));
  //   }
  // }
  //
  // @override
  // Future<Either<Exception, String>> postCheckOut(
  //     {required int shipping_id,
  //     required String country,
  //     required String city,
  //     required String address,
  //     required String phone,
  //     required String amount,
  //     required String code,
  //     required int payment_type}) async {
  //   try {
  //     var body = {
  //       'shipping_id': shipping_id,
  //       'country': country,
  //       'city': city,
  //       'address': address,
  //       'phone': phone,
  //       'amount': amount,
  //       'code': code,
  //       'payment_type': payment_type
  //     };
  //
  //     FormData formData = FormData.fromMap(body);
  //     var response = await DioHelper.postLoggedUser(
  //         url: POST_CHECK_OUT, formData: formData);
  //     String? message;
  //     print(response.data);
  //     if (response.statusCode! < 500) {
  //       message = response.data;
  //       print(message);
  //     }
  //     return Right(message!);
  //   } catch (error) {
  //     return Left(Exception(error));
  //   }
  // }
  //
  // @override
  // Future<Either<Exception, CouponModel>> checkCouponValidation(
  //     String coupon, int subTotal) async {
  //   try {
  //     var response = await DioHelper.postLoggedUser(url: COUPON, data: {
  //       'code': coupon,
  //       'subTotal': subTotal,
  //     });
  //
  //     CouponModel? couponModel;
  //     if (response.statusCode! < 500) {
  //       couponModel = CouponModel.fromJson(response.data);
  //     }
  //     return Right(couponModel!);
  //   } catch (error) {
  //     return Left(Exception(error));
  //   }
  // }
}
