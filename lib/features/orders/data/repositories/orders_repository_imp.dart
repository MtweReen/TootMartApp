
import '../../domain/repositories/orders_repo.dart';

class OrdersRepositoryImpl extends OrdersRepo {
//   @override
//   Future<Either<Exception, OrdersModel>> getAllOrders() async {
//     try {
//       var response = await DioHelper.getLoggedUserData(url: ORDERS);
//       print(response.data);
//       OrdersModel? ordersModel;
//       if (response.statusCode! < 500) {
//         ordersModel = OrdersModel.fromJson(response.data);
//       }
//       return Right(ordersModel!);
//     } catch (error) {
//       return Left(Exception(error));
//     }
//   }
//
//   @override
//   Future<Either<Exception, OrdersModel>> refundOrder(int orderId) async {
//     try {
//       var response = await DioHelper.postLoggedUser(
//           url: REFUND_ORDER, data: {'id': orderId});
//
//       OrdersModel? ordersModel;
//       if (response.statusCode! < 500) {
//         ordersModel = OrdersModel.fromJson(response.data);
//       }
//       return Right(ordersModel!);
//     } catch (error) {
//       return Left(Exception(error));
//     }
// }
}
