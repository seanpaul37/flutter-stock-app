// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../blocs/delete_product_bloc.dart';

abstract class DeleteProductEvent {}

class DeleteProductLoadedEvent extends DeleteProductEvent {
  final String id;
  DeleteProductLoadedEvent(
    this.id,
  );
}
