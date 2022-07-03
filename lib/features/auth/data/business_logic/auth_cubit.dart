import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/constants/constants.dart';

import '../../../../../core/helper/functions/show_toast.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../model/favourites_model.dart';
import '../model/user_model.dart';
import '../repositories/auth_repository_imp.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  User? user;

  User? LoginUser(String Username, String Password) {
    emit(LoginUserLoadingstate());
    AuthRepositoryImpl()
        .loginWithEmailAndPassword(Username: Username, Password: Password)
        .then((value) {
      if (value != []) {
        user = value.getOrElse(() {
          return User.fromJson({});
        });

        if (user!.data!.token == null || user!.data!.token == '') {
          showToast(msg: 'LocaleKeys.error_in_sign_in.tr()', state: ToastStates.ERROR);
          emit(LoginUserErrorstate());
        } else {
          showToast(
              msg: 'LocaleKeys.signed_in_successfully.tr()',
              state: ToastStates.SUCCESS);
          emit(LoginUserLoaded());
          print(user!.data!.token);
        }
      }
    });
    return null;
  }

  User? RegisterUser(String name, String phone, String email, String password) {
    emit(RegisterUserLoadingState());
    AuthRepositoryImpl()
        .registerWithEmailAndPassword(
            name: name, phone: phone, email: email, password: password)
        .then((value) {
      if (value != null) {
        user = value.getOrElse(() => User.fromJson({}));
        if(user!.data!.token !=''){
          showToast(
              msg: 'LocaleKeys.signed_in_successfully.tr()',
              state: ToastStates.SUCCESS);
          emit(RegisterUserSuccessState());
        }else{
          if(user!.message.toString() == 'The email field must be unique.'){
            showToast(
                msg:'هذا البريد الالكتروني مستخدم من قبل',
                state: ToastStates.ERROR);
          }else if(user!.message.toString() == 'The mobile has already been taken.'){
            showToast(
                msg:'رقم الهاتف مستخدم من قبل',
                state: ToastStates.ERROR);
          }else{
            showToast(
                msg:'البريد الالكترني و رقم الهاتف تم استخدامهم من قبل',
                state: ToastStates.ERROR);
          }

          emit(RegisterUserErrorState());
        }

        print(value);
      }else{
        showToast(
            msg:  ' خطأ في تسجيل الدخول',
            state: ToastStates.ERROR);
        emit(RegisterUserErrorState());
      }
    });
    return null;
  }

  User? editProfile({required String name,required String phone,required String email}) {
    emit(EditProfileLoadingState());
    AuthRepositoryImpl()
        .editProfile(
            name: name, phone: phone, email: email)
        .then((value) {
      if (value != []) {
        user = value.getOrElse(() => User.fromJson({}));
        showToast(
            msg: 'تم تعديل البيانات بنجاح',
            state: ToastStates.SUCCESS);
        kUser =user;
        emit(EditProfileSuccessState());
      }
    });
    return null;
  }

  Future<User>? SignOut() {
    AuthRepositoryImpl().SignOut().then((value) {
      if (value != []) {
        kUser = null;
        CasheHelper.removeData(key: 'User');
        showToast(
            msg: value.getOrElse(() => 'not signed out'),
            state: ToastStates.SUCCESS);
        emit(UserSignedOutSuccessfully());
      }
    });
    return null;
  }
  Future<User>? changePassword({
  required String oldPassword,
  required String newPassword,
  required String newPasswordConfirmation,
}) {
    AuthRepositoryImpl().changePassword(oldPassword, newPassword, newPasswordConfirmation).then((value) {
      if (value != []) {
        showToast(
            msg: value.getOrElse(() => 'not signed out'),
            state: ToastStates.SUCCESS);
        emit(PasswordChangedSuccessfully());
      }
    });
    return null;
  }
  int? currentUserState;
  changeUserState(int userState){
    currentUserState = userState;
    print(currentUserState.toString());
    emit(ChangeUserState());
  }
  // FavouritesModel? favouritesModel;
  // List<Product>? getFavouteProducts() {
  //   emit(FavouteProductsLoadingState());
  //   AuthRepositoryImpl().getFavouriteProducts().then((value) {
  //     if (value != []) {
  //       if(favouritesModel !=null) {
  //         favouritesModel!.data = [];
  //       }
  //       favouritesModel =
  //           value.getOrElse(() => FavouritesModel.fromJson({}));
  //       emit(FavouteProductsSuccessState());
  //     }
  //   });
  //   return null;
  // }

  // RefundOrdersModel? refundOrdersModel;
  //
  // List<OrdersModel>? getRefundOrders() {
  //   emit(AllRefundOrdersLoadingState());
  //   AuthRepositoryImpl().getRefundOrders().then((value) {
  //     if (value != []) {
  //
  //       refundOrdersModel = value.getOrElse(() {
  //         emit(AllRefundOrdersErrorState());
  //         return RefundOrdersModel.fromJson({});
  //       });
  //       emit(AllRefundOrdersSuccessState());
  //     }
  //
  //   });
  //   return null;
  // }
}
