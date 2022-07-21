// ignore_for_file: avoid_print, unused_local_variable, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import '../../core/constants/constants.dart';
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
          print('sssssssssssssssssssssssssssssssssssssssss');
          print('gggggggggggggggggggggggg  : ' + result.user!.email!);
          print(result.user!.uid);
          prefs.setString('email', result.user!.email!);

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
  
    final user = await signInWithAppleServices(
        scopes: [Scope.email, Scope.fullName]);
    print('uid: ${user.uid}');
      emit(AppleAuthniticationSuccessState());
  } catch (e) {
    emit(AppleAuthniticationErrorState(e.toString()));
    print(e);
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
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
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
