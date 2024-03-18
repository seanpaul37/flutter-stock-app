import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/IDataResponse.dart';
import '../../services/ApiProvider.dart';

part '../events/add_gest_event.dart';
part '../states/add_gest_states.dart';

class AddGestBloc extends Bloc<AddGestEvent, AddGestState> {
  AddGestBloc() : super(AddGestInitilaState()) {
    on<AddGestEvent>(_addGest);
  }
  Future<FutureOr<void>> _addGest(
      AddGestEvent event, Emitter<AddGestState> emit) async {
    emit(AddGestLoading());

    try {
      DataResponse response = await ApiProvider.addGest(event.payload);
      if (response.statusCode == 200) {
        emit(AddGestLoaded(response.data));
      } else {
        emit(AddGestError(
            response.statusMessage ?? "Une erreur s'est produite"));
      }
    } catch (e) {
      emit(AddGestError(e.toString()));
    }
  }
}
