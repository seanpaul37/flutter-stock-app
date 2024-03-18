// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../blocs/update_product_bloc.dart';

abstract class UpdateProductBlocEvent {}

class UpdateProductEvent extends UpdateProductBlocEvent {
  final dynamic payload;
  final String id;
  UpdateProductEvent({
    required this.payload,
    required this.id,
  });
}

class UpdateProductLoadedEvent extends UpdateProductBlocEvent {
  UpdateProductLoadedEvent();
}
