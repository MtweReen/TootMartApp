// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/data/model/room_filter.dart';
import 'package:toot_mart/data/model/user_address.dart';
import '../../../core/constants/constants.dart';
import '../../../core/network/end_points.dart';
import '../../../data/model/area.dart';
import 'check_out_states.dart';

class CheckOutCubit extends Cubit<CheckOutStates> {
  CheckOutCubit() : super(CheckOutInitial());

  static CheckOutCubit get(context) => BlocProvider.of(context);

  int currentTimeLine = 0;

  void moveInTimeLine(int page) {
    currentTimeLine = page;
    emit(MoveInTimeLineState());
  }

  AreasModel? areasModel;
  Future<AreasModel>? getAreas() async {
    emit(GetAreasLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + GET_AREA,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        areasModel = AreasModel.fromJson(response.data);
        emit(GetAreasSuccessState());
        return areasModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetAreasErrorState(e.toString()));
    }
    return areasModel!;
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////

  AreaFilterResult? areaFilterResult;
  bool isfilterring = false;
  Future<AreaFilterResult>? getFilterArea({required int areaId}) async {
    emit(GetAreasFilterLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + FILTER_ROOM + "$areaId",
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        isfilterring = true;
        areaFilterResult = AreaFilterResult.fromJson(response.data);
        emit(GetAreasFilterSuccessState());
        return areaFilterResult!;
      }
    } catch (e) {
      isfilterring = false;
      print(e.toString());
      emit(GetAreasFilterErrorState(e.toString()));
    }
    return areaFilterResult!;
  }
////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addUserAddress(
      {required String address, required int areaId}) async {
    emit(AddUserAddressLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + ADD_ADDRESS,
        data: {
          "area_id": areaId,
          "address": address,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        emit(AddUserAddressSuccessState());
      }
    } catch (e) {
      print(e.toString());
      emit(AddUserAddressErrorState(e.toString()));
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////

  UserAddressModel? userAddressModel;
  Future<UserAddressModel>? getUserAddress() async {
    emit(GetUserAddressLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + GETUSERADDRESS,
        options: Options(
          headers: {
            "Authorization": "Bearer " + kUser!.body!.accessToken!,
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        userAddressModel = UserAddressModel.fromJson(response.data);
        emit(AddUserAddressSuccessState());
        return userAddressModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(GetUserAddressErrorState(e.toString()));
    }
    return userAddressModel!;
  }
}
