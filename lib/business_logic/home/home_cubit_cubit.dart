// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:toot_mart/data/model/home_model.dart';
import 'package:toot_mart/data/model/room.dart';
import 'package:toot_mart/data/model/search.dart';
import '../../core/constants/constants.dart';
import '../../core/network/end_points.dart';
import '../../data/model/favourite.dart';
part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());

  static HomeCubitCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  Future<HomeModel>? getHomeItems() async {
    emit(HomeCubitLoadingState());
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",
      };
      var response =
          await http.get(Uri.parse(kBaseUrl + HOME), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        homeModel = HomeModel.fromJson(data);
        print(response.body);
        emit(HomeCubitSuccessState());
        return homeModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(HomeCubitErrorState(e.toString()));
    }
    return homeModel!;
  }

  /////////////////////////////////////////////////////////////////////////////////////

  Map<int, bool> isFavourite = {};
  FavouriteModel? favouriteModel;
  Future<FavouriteModel> getFavourites() async {
    emit(FavouriteCubitLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + FAVOURITE,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer " + kToken!,
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data['body']['products']) {
          isFavourite[element['id']] = true;          
        }
        favouriteModel = FavouriteModel.fromJson(response.data);
        print(isFavourite);
        emit(FavouriteCubitSuccessState());
        return favouriteModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(FavouriteCubitErrorState(e.toString()));
    }
    return favouriteModel!;
  }

  ///////////////////////////////////////////////////////////////////////////

  addtoFavourites({required int productId}) async {
    emit(AddFavouriteCubitLoadingState());
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${kToken!}",
      };
      print("Bearer ${kToken!}");
      print(productId);
      Map<String, dynamic> body = {"product_id": "$productId"};
      Response response = await Dio().post(kBaseUrl + ADD_TO_FAVOURITE,
          options: Options(headers: headers), data: body);

      if (response.data['status'] == true) {
        if (response.data['message'] == "added to favourites successfully !") {
          isFavourite[productId] = true;
          print(response.data);
          emit(AddFavouriteCubitSuccessState());
        } else if (response.data['message'] ==
            "removed from from favourites successfully !") {
          isFavourite[productId] = false;
          print(response.data);
          emit(AddFavouriteCubitSuccessState());
        }
      }
    } catch (e) {
      print(e.toString());
      emit(AddFavouriteCubitErrorState(e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////

  SearchModel? searchModel;
  Future<SearchModel> getSearchResult({required String keyword}) async {
    emit(SearchProductsCubitLoadingState());
    try {
      Response response = await Dio().post(
        kBaseUrl + SEARCH,
        data: {"title": keyword},
        queryParameters: {
          "Accept-Language": prefs.get("lang") ?? "ar",
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            // "Authorization": "Bearer ${kToken!}",
          },
        ),
      );
      print('ksajdflakbsdjndsf.s${response.statusCode}');
      if (response.statusCode == 200) {
        searchModel = SearchModel.fromJson(response.data);
        print(response.data);
        emit(SearchProductsCubitSuccessState());
        return searchModel!;
      }
    } catch (e) {
      print('الايرور هنااااااااااااااااااااا'+e.toString());
      emit(SearchProductsCubitErrorState(e.toString()));
    }
    return searchModel!;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////
  RoomModel? roomModel;
  Future<RoomModel> getRooms() async {
    emit(RoomsCubitLoadingState());
    try {
      Response response = await Dio().get(
        kBaseUrl + ROOM,
        options: Options(headers: {"Accept": "application/json"}),
      );
      if(response.statusCode == 200){
        print(response.data);
        roomModel = RoomModel.fromJson(response.data);
        emit(RoomsCubitSuccessState());
        return roomModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(RoomsCubitErrorState(e.toString()));
    }
    return roomModel!;
  }
}
