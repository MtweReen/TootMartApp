part of 'checkout_cubit.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class GetAreasLoadingState extends CheckoutState {}

class GetAreasSuccessState extends CheckoutState {}

class GetAreasErrorState extends CheckoutState {
  final String error;

  GetAreasErrorState(this.error);
}
