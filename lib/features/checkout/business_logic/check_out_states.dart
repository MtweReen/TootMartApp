abstract class CheckOutStates {}

class CheckOutInitial extends CheckOutStates {}

class CheckOutLoadingState extends CheckOutStates {}

class CheckOutSuccessState extends CheckOutStates {}

class CouponValidateLoadingState extends CheckOutStates {}

class CouponValidateSuccessState extends CheckOutStates {}

class CouponValidateErrorState extends CheckOutStates {}

class PostCheckOutLoadingState extends CheckOutStates {}

class PostCheckOutSuccessState extends CheckOutStates {}

class PostCheckOutErrorState extends CheckOutStates {}

class DropDownChangeState extends CheckOutStates {}

class MoveInTimeLineState extends CheckOutStates {}

class GetAreasLoadingState extends CheckOutStates {}

class GetAreasSuccessState extends CheckOutStates {}

class GetAreasErrorState extends CheckOutStates {
  final String error;

  GetAreasErrorState(this.error);
}

class GetAreasFilterLoadingState extends CheckOutStates {}

class GetAreasFilterSuccessState extends CheckOutStates {}

class GetAreasFilterErrorState extends CheckOutStates {
  final String error;

  GetAreasFilterErrorState(this.error);
}

class AddUserAddressLoadingState extends CheckOutStates {}

class AddUserAddressSuccessState extends CheckOutStates {}

class AddUserAddressErrorState extends CheckOutStates {
  final String error;

  AddUserAddressErrorState(this.error);
}

class GetUserAddressLoadingState extends CheckOutStates {}

class GetUserAddressSuccessState extends CheckOutStates {}

class GetUserAddressErrorState extends CheckOutStates {
  final String error;

  GetUserAddressErrorState(this.error);
}

class CreateOrderLoadingState extends CheckOutStates {}

class CreateOrderSuccessState extends CheckOutStates {}

class CreateOrderErrorState extends CheckOutStates {
  final String error;

  CreateOrderErrorState(this.error);
}

class GetOrdersLoadingState extends CheckOutStates {}

class GetOrdersSuccessState extends CheckOutStates {}

class GetOrdersErrorState extends CheckOutStates {
  final String error;

  GetOrdersErrorState(this.error);
}

class GetOrderDetailLoadingState extends CheckOutStates {}

class GetOrderDetailSuccessState extends CheckOutStates {}

class GetOrderDetailErrorState extends CheckOutStates {
  final String error;

  GetOrderDetailErrorState(this.error);
}

class RefundOrdersLoadingState extends CheckOutStates {}

class RefundOrdersSuccessState extends CheckOutStates {}

class RefundOrdersErrorState extends CheckOutStates {
  final String error;

  RefundOrdersErrorState(this.error);
}
