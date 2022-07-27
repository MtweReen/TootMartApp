part of 'home_cubit_cubit.dart';

@immutable
abstract class HomeCubitState {}

class HomeCubitInitial extends HomeCubitState {}
class HomeCubitLoadingState extends HomeCubitState {}
class HomeCubitSuccessState extends HomeCubitState {}
class HomeCubitErrorState extends HomeCubitState {
  final String error;

  HomeCubitErrorState(this.error);
}

class FavouriteCubitLoadingState extends HomeCubitState {}
class FavouriteCubitSuccessState extends HomeCubitState {}
class FavouriteCubitErrorState extends HomeCubitState {
  final String error;

  FavouriteCubitErrorState(this.error);
}


class AddFavouriteCubitLoadingState extends HomeCubitState {}
class AddFavouriteCubitSuccessState extends HomeCubitState {}
class AddFavouriteCubitErrorState extends HomeCubitState {
  final String error;

  AddFavouriteCubitErrorState(this.error);
}
