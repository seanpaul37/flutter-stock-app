part of '../blocs/list_product_bloc.dart';

abstract class ProductEvent {}

class ProductLoadedEvent extends ProductEvent {
  ProductLoadedEvent();
}
