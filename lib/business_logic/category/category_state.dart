part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoryLoadingState extends CategoryState {}
class CategorySuccessState extends CategoryState {}
class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);

}


class SubCategoryLoadingState extends CategoryState {}
class SubCategorySuccessState extends CategoryState {}
class SubCategoryErrorState extends CategoryState {
  final String error;

  SubCategoryErrorState(this.error);

}


class ProductDetailLoadingState extends CategoryState {}
class ProductDetailSuccessState extends CategoryState {}
class ProductDetailErrorState extends CategoryState {
  final String error;

  ProductDetailErrorState(this.error);

}