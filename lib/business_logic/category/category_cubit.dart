// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:toot_mart/core/network/end_points.dart';

import '../../core/constants/constants.dart';
import '../../data/model/category.dart';
import '../../data/model/product_detail.dart';
import '../../data/model/subcategory.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryModel? categoryModel;
  Future<CategoryModel>? getCategory({required int page}) async {
    emit(CategoryLoadingState());

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
        "paginate": "$page"
      };
      var response =
          await http.get(Uri.parse(kBaseUrl + CATEGORIES), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        categoryModel = CategoryModel.fromJson(data);
        print(response.body);
        emit(CategorySuccessState());
        return categoryModel!;
      }
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
    return categoryModel!;
  }

  /////////////////////////////////////////////////////////////////////////////////

  SubcategoryModel? subcategoryModel;
  Future<SubcategoryModel>? getSubsCategory({required int id}) async {
    emit(SubCategoryLoadingState());

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",
      };
      var response = await http.get(Uri.parse(kBaseUrl + "category/$id"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        subcategoryModel = SubcategoryModel.fromJson(data);
        emit(SubCategorySuccessState());
        return subcategoryModel!;
      }
    } catch (e) {
      emit(SubCategoryErrorState(e.toString()));
    }
    return subcategoryModel!;
  }

  //////////////////////////////////////////////////////////////////////////////////////

  ProductDetailModel? productDetailModel;
  Future<ProductDetailModel>? getProductDetail({required int id}) async {
    emit(ProductDetailLoadingState());

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",
      };
      var response =
          await http.get(Uri.parse(kBaseUrl + "product/$id"), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        productDetailModel = ProductDetailModel.fromJson(data);
        emit(ProductDetailSuccessState());
        return productDetailModel!;
      }
    } catch (e) {
      emit(ProductDetailErrorState(e.toString()));
    }
    return productDetailModel!;
  }
}
