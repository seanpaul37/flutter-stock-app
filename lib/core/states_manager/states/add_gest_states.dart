part of '../blocs/add_gest_bloc.dart';

abstract class AddGestState {}

class AddGestInitilaState extends AddGestState {}

class AddGestLoading extends AddGestState {}

class AddGestLoaded extends AddGestState {
  final dynamic datas;

  AddGestLoaded(this.datas);
}

class AddGestError extends AddGestState {
  final String message;
  AddGestError(this.message);
}
