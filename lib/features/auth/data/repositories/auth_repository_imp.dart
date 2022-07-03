import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/core/network/remote/dio_helper.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

import '../../../../../core/helper/functions/show_toast.dart';
import '../../domain/repositories/auth_repo.dart';
import '../model/favourites_model.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl extends AuthRepo {
  @override
  Future<Either<Exception, User>> loginWithEmailAndPassword(
      {required String Username, required String Password}) async {
    try {
      var response = await DioHelper.postData(
          url: LOGIN, data: {'email': Username, 'password': Password});
      User? result;
      if (response.statusCode! < 500) {
        result = User.fromJson(response.data);
      }
      return Right(result!);
    } catch (error) {
      showToast(
          msg: 'LocaleKeys.error_in_sign_in.tr()', state: ToastStates.ERROR);
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, dynamic>> registerWithEmailAndPassword(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    try {
      var response = await DioHelper.postData(url: REGISTER, data: {
        'name': name,
        'mobile': phone,
        'email': email,
        'password': password
      });
      User? result;
    //  ErrorRegisterModel errorRegisterModel;
      if (response.statusCode!<500) {
        result = User.fromJson(response.data);
      }
      return Right(result!);
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, String>> SignOut() async {
    try {
      var response = await DioHelper.postLoggedUser(
        url: SIGNOUT,
      );
      //

      return Right('LocaleKeys.signed_out_successfully.tr()');
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, FavouritesModel>> getFavouriteProducts() async {
    try {
      var response = await DioHelper.getLoggedUserData(url: FAVOURITES);

      FavouritesModel? result;
      if (response.statusCode! < 500) {
        result = FavouritesModel.fromJson(response.data);
      }
      return Right(result!);
    } catch (error) {
      return Left(Exception(error));
    }
  }

  // @override
  // Future<Either<Exception, RefundOrdersModel>> getRefundOrders() async {
  //   try {
  //     var response = await DioHelper.getLoggedUserData(url: REFUND_ORDERS);
  //     RefundOrdersModel? refundOrdersModel;
  //     if (response.statusCode! < 500) {
  //       refundOrdersModel = RefundOrdersModel.fromJson(response.data);
  //     }
  //     return Right(refundOrdersModel!);
  //   } catch (error) {
  //     return Left(Exception(error));
  //   }
  // }

  @override
  Future<Either<Exception, User>> editProfile(
      {required String name,
      required String phone,
      required String email}) async {
    try {
      var response = await DioHelper.postLoggedUser(url: EDIT_PROFILE, data: {
        'name': name,
        'mobile': phone,
        'email': email,
      });
      
      User? result;
      if (response.statusCode == 200) {
        result = User.fromJson(response.data);
      }
      return Right(result!);
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, String>> changePassword(
      String oldPassword, String newPassword, String newPasswordConfirmation) async{
    try {
      var response = await DioHelper.postLoggedUser(
        url: CHANGE_PASSWORD,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'newPasswordConfirmation': newPasswordConfirmation,
        }
      );
      

      return const Right('تم تغير كلمة السر بنجاح');
    } catch (error) {
      return Left(Exception(error));
    }
  }
}
