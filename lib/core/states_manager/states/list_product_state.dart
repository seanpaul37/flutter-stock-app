part of '../blocs/list_product_bloc.dart';

abstract class ProductState {}

class ProductInitilaState extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  dynamic productList;

  ProductLoaded(this.productList);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
