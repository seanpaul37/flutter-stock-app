// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../blocs/update_product_bloc.dart';

abstract class UpdateProductState {}

class UpdateProductInitilaState extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductLoaded extends UpdateProductState {
  dynamic updateProductList;

  UpdateProductLoaded(
    this.updateProductList,
  );
}

class UpdateProductError extends UpdateProductState {
  final String message;
  UpdateProductError(this.message);
}
