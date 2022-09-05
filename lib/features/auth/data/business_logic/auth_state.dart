abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginUserLoadingstate extends AuthStates {}

class LoginUserErrorstate extends AuthStates {}

class LoginUserLoaded extends AuthStates {}

class RegisterUserLoadingState extends AuthStates {}

class RegisterUserSuccessState extends AuthStates {}

class RegisterUserErrorState extends AuthStates {}

class EditProfileLoadingState extends AuthStates {}

class EditProfileSuccessState extends AuthStates {}

class UserSignedOutSuccessfully extends AuthStates {}

class PasswordChangedSuccessfully extends AuthStates {}

class AccountDeletedSuccessfully extends AuthStates {}

class FavouteProductsLoadingState extends AuthStates {}

class FavouteProductsSuccessState extends AuthStates {}

class CheckedSuccessState extends AuthStates {}

class ChangeUserState extends AuthStates {}


class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordSuccessState extends AuthStates {}

class ChangePasswordErrorState extends AuthStates {
  final String e;

  ChangePasswordErrorState(this.e);
}

class ForgetPasswordLoadingState extends AuthStates {}

class ForgetPasswordSuccessState extends AuthStates {}

class ForgetPasswordErrorState extends AuthStates {
  final String e;

  ForgetPasswordErrorState(this.e);
}

