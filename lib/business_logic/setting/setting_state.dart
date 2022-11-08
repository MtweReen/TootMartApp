part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class ContactusLoadingState extends SettingState {}

class ContactusSuccessState extends SettingState {}

class ContactusErrorState extends SettingState {
  final String error;

  ContactusErrorState(this.error);
}

// class SettingLoadingState extends SettingState {}

// class SettingSuccessState extends SettingState {}

// class SettingErrorState extends SettingState {
//   final String error;

//   SettingErrorState(this.error);
// }

// class PrivacypolicyLoadingState extends SettingState {}

// class PrivacypolicySuccessState extends SettingState {}

// class PrivacypolicyErrorState extends SettingState {
//   final String error;

//   PrivacypolicyErrorState(this.error);
// }
