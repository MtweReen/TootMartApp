abstract class OrdersStates {}

class OrdersInitialstate extends OrdersStates {}

class OrdersLoadingState extends OrdersStates {}

class OrdersSuccessState extends OrdersStates {}
class OrdersErrorState extends OrdersStates {}

class RefundOrderLoadingState extends OrdersStates {}

class RefundOrderSuccessState extends OrdersStates {}
class RefundOrderErrorState extends OrdersStates {}
