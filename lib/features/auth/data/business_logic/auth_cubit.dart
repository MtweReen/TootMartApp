// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, avoid_print, non_constant_identifier_names, duplicate_ignore
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/network/end_points.dart';
import '../../../../../core/helper/functions/show_toast.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../account/account.dart';
import '../model/user_model.dart';
import '../repositories/auth_repository_imp.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel? user;

  // ignore: non_constant_identifier_names

  getUser() async{
    if(kToken !=null){
      emit(LoginUserLoadingstate());
      try {
        Response response = await Dio().get(
          kBaseUrl + "user",
          options: Options(headers: {
            "Authorization": "Bearer ${kToken!}",
          }),
        );
        if (response.statusCode == 200) {
          print(response.data);
          user=UserModel.fromJson(response.data);
          kUser=user;
          emit(LoginUserLoaded());
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
  UserModel? LoginUser(String Username, String Password) {
    emit(LoginUserLoadingstate());
    AuthRepositoryImpl()
        .loginWithEmailAndPassword(Username: Username, Password: Password)
        .then((value) {
      if (value != []) {
        user = value.getOrElse(() {
          return UserModel.fromJson({});
        });
        kUser=user;
        kToken=user!.body!.accessToken;

        print('skdhfbalksdfaksdf' + userModelToJson(user!));
        if (kToken == null || kToken == '') {
          showToast(
              msg: LocaleKeys.error_in_sign_in.tr(), state: ToastStates.ERROR);
          emit(LoginUserErrorstate());
        } else {
          showToast(
              msg: LocaleKeys.signed_in_successfully.tr(),
              state: ToastStates.SUCCESS);
          showDeleteButton();
          emit(LoginUserLoaded());
        }
      }
    });
    return null;
  }

//////////////////////////////////////////////////////////////////
  UserModel? RegisterUser(
      String name, String phone, String email, String password) {
    emit(RegisterUserLoadingState());
    AuthRepositoryImpl()
        .registerWithEmailAndPassword(
            name: name, phone: phone, email: email, password: password)
        .then((value) {
      if (value != null) {
        user = value.getOrElse(() => UserModel.fromJson({}));
        if (user!.body!.accessToken != '') {
          showToast(
              msg: LocaleKeys.signed_in_successfully.tr(),
              state: ToastStates.SUCCESS);
          showDeleteButton();
          emit(RegisterUserSuccessState());
        } else {
          if (user!.message.toString() == 'The email field must be unique.') {
            showToast(
                msg: 'هذا البريد الالكتروني مستخدم من قبل',
                state: ToastStates.ERROR);
          } else if (user!.message.toString() ==
              'The mobile has already been taken.') {
            showToast(
                msg: 'رقم الهاتف مستخدم من قبل', state: ToastStates.ERROR);
          } else {
            showToast(
                msg: 'البريد الالكترني و رقم الهاتف تم استخدامهم من قبل',
                state: ToastStates.ERROR);
          }
          emit(RegisterUserErrorState());
        }

        print(value);
      } else {
        showToast(msg: ' خطأ في تسجيل الدخول', state: ToastStates.ERROR);
        emit(RegisterUserErrorState());
      }
    });
    return null;
  }

//////////////////////////////////////////////////////////
  UserModel? editProfile(
      {required String name, required String phone, required String email}) {
    emit(EditProfileLoadingState());
    AuthRepositoryImpl()
        .editProfile(name: name, phone: phone, email: email)
        .then((value) {
      if (value != []) {
        user = value.getOrElse(() => UserModel.fromJson({}));
        showToast(msg: 'تم تعديل البيانات بنجاح', state: ToastStates.SUCCESS);
        kUser = user;
        CasheHelper.setToken(token: user!.body!.accessToken!);
        emit(EditProfileSuccessState());
      }
    });
    return null;
  }

//////////////////////////////////////////////////////
  Future<UserModel>? SignOut() {
    AuthRepositoryImpl().SignOut().then((value) {
      if (value != []) {
        changeUserState(AccountStates.GUEST);
        kToken = null;
        CasheHelper.removeData(key: 'User');
        showToast(
            msg: value.getOrElse(() => 'not signed out'),
            state: ToastStates.SUCCESS);

        prefs.clear();
        FirebaseAuth.instance.signOut();
        emit(UserSignedOutSuccessfully());
      }
    });
    return null;
  }

////////////////////////////////////////////////////////////////////////
  Future<UserData>? changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    AuthRepositoryImpl()
        .changePassword(oldPassword, newPassword, newPasswordConfirmation)
        .then((value) {
      if (value != []) {
        showToast(
            msg: value.getOrElse(() => 'not signed out'),
            state: ToastStates.SUCCESS);
        emit(PasswordChangedSuccessfully());
      }
    });
    return null;
  }

////////////////////////////////////////////////////////////////
  Future<void>? deleteAccount() {
    AuthRepositoryImpl().deleteAccount().then((value) {
      if (value != []) {
        showToast(
            msg: value.getOrElse(() => 'لم يتم حزف الحساب'),
            state: ToastStates.SUCCESS);
        kToken = null;
        CasheHelper.removeData(key: 'user');
        emit(AccountDeletedSuccessfully());
      }
    });
    return null;
  }

  AccountStates? currentUserState;
  changeUserState(AccountStates userState) {
    currentUserState = userState;
    emit(ChangeUserState());
  }

}

///////////////////////////////////////////////////////////////////
Future<bool>? showDeleteButton() async {
  try {
    Response response = await Dio().get(
      kBaseUrl + "delete_acc_button",
      options: Options(headers: {
        "Authorization": "Bearer ${kToken!}",
      }),
    );
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['body']['delete_account_button_status'] == true) {
        return true;
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return false;
}
