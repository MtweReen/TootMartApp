import 'package:dartz/dartz.dart';

import '../../data/model/favourites_model.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Exception, User>> loginWithEmailAndPassword(
      {required String Username, required String Password});

  Future<Either<Exception, dynamic>> registerWithEmailAndPassword(
      {required String name,
      required String phone,
      required String email,
      required String password});

  Future<Either<Exception, User>> editProfile(
      {required String name,
      required String phone,
      required String email,
      });

  Future<Either<Exception, String>> SignOut();
  Future<Either<Exception, String>> changePassword(String oldPassword,String newPassword,String newPasswordConfirmation);

  Future<Either<Exception, FavouritesModel>> getFavouriteProducts();

  // Future<Either<Exception, RefundOrdersModel>> getRefundOrders();
}
