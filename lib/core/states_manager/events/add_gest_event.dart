// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../blocs/add_gest_bloc.dart';

abstract class AddGestBlocEvent {}

class AddGestEvent extends AddGestBlocEvent {
  final dynamic payload;
  AddGestEvent(this.payload);
}

class GestLoadedEvent extends AddGestBlocEvent {
  GestLoadedEvent();
}
