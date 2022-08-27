// ignore_for_file: avoid_print, unused_local_variable, unnecessary_null_comparison, file_names

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import '../../core/constants/constants.dart';
import '../../core/helper/functions/show_toast.dart';
import '../../core/network/end_points.dart';
import '../../core/network/local/cache_helper.dart';
import '../../features/auth/data/model/user_model.dart';
part 'socialState.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignUp(BuildContext context) async {
    emit(GoogleAuthniticationLoadingState());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;

        if (result != null) {
          print('gggggggggggggggggggggggg  : ' + result.user!.email!);

          print(result.user!.uid);
         
          prefs.setString('email', result.user!.email!);
          prefs.setString('uid', result.user!.uid.toString());
          prefs.setBool('social_login', true);
         
          emit(GoogleAuthniticationSuccessState());
        } else {
          print('fffffffffffffffffffffffffffffffffffff');
        }
      }
    } catch (e) {
      print(e.toString());
      emit(GoogleAuthniticationErrorState(e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////////////////////

  Future<void> signInWithApple(BuildContext context) async {
    emit(AppleAuthniticationLoadingState());
    try {
      final user =
          await signInWithAppleServices(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
          prefs.setString('email', user.email.toString());
          prefs.setString('uid', user.uid.toString());
          prefs.setBool('social_login', true);
      emit(AppleAuthniticationSuccessState());
    } catch (e) {
      emit(AppleAuthniticationErrorState(e.toString()));
      print(e);
    }
  }
/////////////////////////////////////////////////////////////////////////

 UserModel? userModel;
  Future socialLoginApi(context) async {
    emit(SocialLoginApiLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + SOCIAL_LOGIN,
        data: {
          "email": prefs.getString('email').toString(),
          "password": prefs.getString('uid').toString(),
        },
      );
      print(prefs.getString('email').toString());
      print(prefs.getString('uid').toString());
      if (response.statusCode == 200) {
        showToast(
            msg: translateString("login success", "تم تسجيل الدخول بنجاح"),
            state: ToastStates.SUCCESS);
        userModel = UserModel.fromJson(response.data);
        kUser = userModel;
        kToken=userModel!.body!.accessToken!;
        CasheHelper.setToken(token: userModel!.body!.accessToken!);
     
        emit(SocialLoginApiSuccessState());
      }
    } catch (e) {
      showToast(
          msg: e.toString(),
          // translateString("there is error , please try again later",
          //     "حدث خطأ ما , الرجاء المحاولة في وقت لاحق"),
          state: ToastStates.ERROR);
      print(e.toString());
      emit(SocialLoginApiErrorState(e.toString()));
    }
  }
}





//////////////////////////////////////////////////////////////////////////
final _firebaseAuth = FirebaseAuth.instance;

Future<User> signInWithAppleServices({List<Scope> scopes = const []}) async {
  final result = await TheAppleSignIn.performRequests(
      [AppleIdRequest(requestedScopes: scopes)]);
  // 2. check the result
  switch (result.status) {
    case AuthorizationStatus.authorized:
      final appleIdCredential = result.credential!;
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: String.fromCharCodes(appleIdCredential.identityToken!),
        accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user!;
      if (scopes.contains(Scope.fullName)) {
        final fullName = appleIdCredential.fullName;
        if (fullName != null &&
            fullName.givenName != null &&
            fullName.familyName != null) {
          final displayName = '${fullName.givenName} ${fullName.familyName}';
          await firebaseUser.updateDisplayName(displayName);
        }
      }

      return firebaseUser;
    case AuthorizationStatus.error:
      print(result.error.toString());
      throw PlatformException(
        code: 'ERROR_AUTHORIZATION_DENIED',
        message: result.error.toString(),
      );

    case AuthorizationStatus.cancelled:
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    default:
      throw UnimplementedError();
  }

  
}
