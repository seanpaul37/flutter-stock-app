part of '../blocs/add_product_blocs.dart';

abstract class AddProductState {}

class AddProductInitilaState extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductLoaded extends AddProductState {
  final dynamic datas;

  AddProductLoaded(this.datas);
}

class AddProductError extends AddProductState {
  final String message;
  AddProductError(this.message);
}
