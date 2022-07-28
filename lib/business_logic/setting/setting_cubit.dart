// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/network/end_points.dart';
import '../../data/model/refunds.dart';
import '../../data/model/setting.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(context) => BlocProvider.of(context);

  contactus({
    required String name,
    required String email,
    required String message,
    required context,
  }) async {
    emit(ContactusLoadingState());
    try {
      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "message": message,
      };
      Response response = await Dio().post(
        kBaseUrl + CONTACTUS,
        data: body,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: translateString(
                "your request send successfully", "تم ارسال طلبك بنجاح"),
            backgroundColor: colordeepGreen,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white);
        Navigator.pop(context);
        emit(ContactusSuccessState());
      }
    } catch (e) {
      print(e.toString());
      emit(ContactusErrorState(e.toString()));
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////
  RefundsModel? refundsModel;
  Future<RefundsModel> refundsPolicy() async {
    emit(SettingLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + SETTINGS,
        queryParameters: {"rule": "refunds"},
      );
      if (response.statusCode == 200) {
        refundsModel = RefundsModel.fromJson(response.data);
        emit(SettingSuccessState());
        return refundsModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(SettingErrorState(e.toString()));
    }
    return refundsModel!;
  }

  ///////////////////////////////////////////////////////////////////////////////////
    SettingModel? settingModel;
  Future<SettingModel>? privacypolicy() async {
    emit(PrivacypolicyLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + SETTINGS,
        queryParameters: {"rule": "privacy"},
      );
      if (response.statusCode == 200) {
        settingModel = SettingModel.fromJson(response.data);
        emit(PrivacypolicySuccessState());
        return settingModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(PrivacypolicyErrorState(e.toString()));
    }
    return settingModel!;
  }

}
