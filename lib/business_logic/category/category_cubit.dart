// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

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
    String url = "https://site.modern-it.net/TOOT/public/api/categories";

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
        "paginate": "$page"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        categoryModel = CategoryModel.fromJson(data);
        print(response.body);
        emit(CategorySuccessState());
        return categoryModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(CategoryErrorState(e.toString()));
    }
    return categoryModel!;
  }

  /////////////////////////////////////////////////////////////////////////////////
  
  
  SubcategoryModel? subcategoryModel;
  Future<SubcategoryModel>? getSubsCategory({required int id}) async {
    emit(SubCategoryLoadingState());
    String url = "https://site.modern-it.net/TOOT/public/api/category/$id";

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",
        
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        subcategoryModel = SubcategoryModel.fromJson(data);
        print(response.body);
        emit(SubCategorySuccessState());
        return subcategoryModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(SubCategoryErrorState(e.toString()));
    }
    return subcategoryModel!;
  }

  //////////////////////////////////////////////////////////////////////////////////////
  
   ProductDetailModel? productDetailModel;
  Future<ProductDetailModel>? getProductDetail({required int id}) async {
    emit(ProductDetailLoadingState());
    String url = "https://site.modern-it.net/TOOT/public/api/product/$id";

    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",  
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        productDetailModel = ProductDetailModel.fromJson(data);
        print(response.body);
        emit(ProductDetailSuccessState());
        return productDetailModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(ProductDetailErrorState(e.toString()));
    }
    return productDetailModel!;
  }


}
