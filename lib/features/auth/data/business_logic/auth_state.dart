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

class FavouteProductsLoadingState extends AuthStates {}

class FavouteProductsSuccessState extends AuthStates {}

class CheckedSuccessState extends AuthStates {}

class AllRefundOrdersLoadingState extends AuthStates {}

class AllRefundOrdersSuccessState extends AuthStates {}

class AllRefundOrdersErrorState extends AuthStates {}
class ChangeUserState extends AuthStates {}
