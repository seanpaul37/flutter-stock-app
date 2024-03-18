// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../blocs/add_product_blocs.dart';

abstract class AddProductBlocEvent {}

class AddProductEvent extends AddProductBlocEvent {
  final dynamic payload;
  AddProductEvent(this.payload);
}

class ProductLoadedEvent extends AddProductBlocEvent {
  ProductLoadedEvent();
}

class DeleteTeacherEvent extends AddProductBlocEvent {
  final String productName;
  DeleteTeacherEvent(this.productName);
}
