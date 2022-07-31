import 'package:dartz/dartz.dart';

import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Exception, UserModel>> loginWithEmailAndPassword(
      {required String Username, required String Password});

  Future<Either<Exception, UserModel>> registerWithEmailAndPassword(
      {required String name,
      required String phone,
      required String email,
      required String password});

  Future<Either<Exception, UserModel>> editProfile(
      {required String name,
      required String phone,
      required String email,
      });

  Future<Either<Exception, String>> SignOut();
  // Future<Either<Exception, String>> changePassword(String oldPassword,String newPassword,String newPasswordConfirmation);
  //
  // Future<Either<Exception, FavouritesModel>> getFavouriteProducts();

  // Future<Either<Exception, RefundOrdersModel>> getRefundOrders();
}
