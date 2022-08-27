part of 'socialCubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}
class GoogleAuthniticationLoadingState extends SocialState {}
class GoogleAuthniticationSuccessState extends SocialState {}
class GoogleAuthniticationErrorState extends SocialState {
  final String error;
  GoogleAuthniticationErrorState(this.error);
}


class AppleAuthniticationLoadingState extends SocialState {}
class AppleAuthniticationSuccessState extends SocialState {}
class AppleAuthniticationErrorState extends SocialState {
  final String error;
  AppleAuthniticationErrorState(this.error);
}

class SocialLoginApiErrorState extends SocialState {
  final String error;

  SocialLoginApiErrorState(this.error);
}

class SocialLoginApiLoadingState extends SocialState {}

class SocialLoginApiSuccessState extends SocialState {}