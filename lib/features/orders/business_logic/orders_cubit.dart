import 'package:flutter_bloc/flutter_bloc.dart';


import 'orders_states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialstate());

  static OrdersCubit get(context) => BlocProvider.of(context);

  // OrdersModel? ordersModel;
  //
  // List<OrdersModel>? getAllOrders() {
  //   emit(OrdersLoadingState());
  //   OrdersRepositoryImpl().getAllOrders().then((value) {
  //     if (value != []) {
  //       ordersModel = value.getOrElse(() {
  //         emit(OrdersErrorState());
  //         return OrdersModel.fromJson({});
  //       });
  //       print(ordersModel!);
  //       emit(OrdersSuccessState());
  //     }
  //   });
  //   return null;
  // }
  //
  // List<OrdersModel>? refundOrder({required int orderId}) {
  //   emit(RefundOrderLoadingState());
  //   OrdersRepositoryImpl().refundOrder(orderId).then((value) {
  //     if (value != []) {
  //       showToast(
  //           msg: 'تم تأكيد طلب الاسترجاع بنجاح', state: ToastStates.SUCCESS);
  //       getAllOrders();
  //       print(ordersModel!);
  //       emit(RefundOrderSuccessState());
  //     }
  //   });
  //   return null;
  // }
}
