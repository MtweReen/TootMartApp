part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddtoCartLoadingState extends CartState {}

class AddtoCartSuccessState extends CartState {}

class AddtoCartErrorState extends CartState {
  final String error;

  AddtoCartErrorState(this.error);
}

class GetCartLoadingState extends CartState {}

class GetCartSuccessState extends CartState {}
class UpdateCartSuccessState extends CartState {}
class UpdateCartErrorState extends CartState {}
class CouponAppliedErrorState extends CartState {}
class CouponAppliedSuccessState extends CartState {}
class CouponRemovedErrorState extends CartState {}
class CouponRemovedSuccessState extends CartState {}

class GetCartErrorState extends CartState {
  final String error;

  GetCartErrorState(this.error);
}
