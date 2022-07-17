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

