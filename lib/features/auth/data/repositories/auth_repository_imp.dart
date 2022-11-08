// ignore_for_file: unused_local_variable, avoid_print, non_constant_identifier_names, duplicate_ignore

import 'package:dartz/dartz.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/core/network/remote/dio_helper.dart';
import '../../../../../core/helper/functions/show_toast.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../domain/repositories/auth_repo.dart';
import '../model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthRepositoryImpl extends AuthRepo {
  @override
  Future<Either<Exception, UserModel>> loginWithEmailAndPassword(
      // ignore: non_constant_identifier_names
      {required String Username,
      required String Password}) async {
    try {
      UserModel? userModel;
      var response = await DioHelper.postData(
          url: LOGIN, data: {'email': Username, 'password': Password});
    print(response.data);
      if (response.statusCode == 200) {
        prefs.setBool("is_login", true);
        prefs.setString('token', response.data['body']['accessToken']);
        userModel = UserModel.fromJson(response.data);
        return Right(userModel);
      } else {
        return Left(Exception("error"));
      }
    } catch (error) {
      showToast(
          msg: LocaleKeys.error_in_sign_in.tr(), state: ToastStates.ERROR);
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, UserModel>> registerWithEmailAndPassword(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    try {
      var response = await DioHelper.postData(url: REGISTER, data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password
      });
      UserModel? result;
      if (response.statusCode == 200) {
        result = UserModel.fromJson(response.data);
        prefs.setBool("is_login", true);
        prefs.setString('token', response.data['body']['accessToken']);
      }
      return Right(result!);
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, UserModel>> editProfile(
      {required String name,
      required String phone,
      required String email}) async {
    try {
      var response = await DioHelper.postLoggedUser(url: EDIT_PROFILE, data: {
        'name': name,
        'phone': phone,
        'email': email,
      });
      UserModel? result;
      if (response.statusCode == 200) {
        result = UserModel.fromJson(response.data);
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
      return Right(LocaleKeys.signed_out_successfully.tr());
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, String>> changePassword(String oldPassword,
      String newPassword, String newPasswordConfirmation) async {
    try {
      var response =
          await DioHelper.postLoggedUser(url: CHANGE_PASSWORD, data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'newPasswordConfirmation': newPasswordConfirmation,
      });
      return const Right('تم تغير كلمة السر بنجاح');
    } catch (error) {
      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, String>> deleteAccount() async {
    try {
      var response = await DioHelper.postLoggedUser(
        url: DELETE_ACCOUNT,
      );
      return const Right('تم حزف الحساب بنجاح . نتمني أن نلتقي مجددا');
    } catch (error) {
      return Left(Exception(error));
    }
  }
}
