// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:toot_mart/data/model/filter.dart';
import 'package:toot_mart/data/model/home_model.dart';

import '../../core/constants/constants.dart';
import '../../data/model/favourite.dart';
part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());

  static HomeCubitCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  Future<HomeModel>? getHomeItems() async {
    String url = "https://site.modern-it.net/TOOT/public/api/home";
    emit(HomeCubitLoadingState());
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
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
  Future<FavouriteModel>? getFavourites() async {
    String url = "https://site.modern-it.net/TOOT/public/api/user/favourites";
    emit(FavouriteCubitLoadingState());
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
        "Accept": "application/json",
        "Authorization": "Bearer " + kUser!.body!.accessToken!,
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        favouriteModel = FavouriteModel.fromJson(data);
        for (var element in data['body']['products']) {
          isFavourite[element['id']] = true;
        }
        print(response.body);
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
    String url = "https://site.modern-it.net/TOOT/public/api/user/add_to_fav";
    emit(AddFavouriteCubitLoadingState());
    try {
      Map<String, String> headers = {
        
        "Accept": "application/json",
        "Authorization": "Bearer ${kUser!.body!.accessToken!}",
      };
print("Bearer ${kUser!.body!.accessToken!}");
print(productId);
      Map<String, dynamic> body = {"product_id": "$productId"};
      Response response =
          await Dio().post(url, options: Options(headers: headers), data: body);
      
      if (response.data['status'] == true) {
        if (response.data['message'] == "added to favourites successfully !") {
          isFavourite[productId] = true;
          print(response.data);
          emit(AddFavouriteCubitSuccessState());
        } else if(response.data['message'] =="removed from from favourites successfully !"){
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



}
