part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class CountrySelection extends AppState {}

class LanguageSelection extends AppState {}

class IntroLoadingState extends AppState {}

class IntroSuccessState extends AppState {}

class IntroErrorState extends AppState {
  final String error;

  IntroErrorState(this.error);
}
