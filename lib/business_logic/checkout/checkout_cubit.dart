
// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/data/model/area.dart';

import '../../core/constants/constants.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  static CheckoutCubit get(context)=> BlocProvider.of(context);

  AreasModel? areasModel;
  Future<AreasModel>? getAreas()async{
    emit(GetAreasLoadingState());
try {
  Response response = await Dio().get(kBaseUrl +GET_AREA, options: Options(
    headers: {
       "Authorization": "Bearer " + kUser!.body!.accessToken!,
    },
  ) ,);

  if(response.statusCode == 200){
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
}
