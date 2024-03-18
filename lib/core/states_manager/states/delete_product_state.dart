part of '../blocs/delete_product_bloc.dart';

abstract class DeleteProductState {}

class DeleteProductInitilaState extends DeleteProductState {}

class DeleteProductLoading extends DeleteProductState {}

class DeleteProductLoaded extends DeleteProductState {
  dynamic productList;

  DeleteProductLoaded(this.productList);
}

class DeleteProductError extends DeleteProductState {
  final String message;
  DeleteProductError(this.message);
}
