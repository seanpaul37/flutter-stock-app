import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/IDataResponse.dart';
import '../../services/ApiProvider.dart';

part '../states/update_product_state.dart';
part '../events/update_product_event.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc() : super(UpdateProductInitilaState()) {
    on<UpdateProductEvent>(_updateProduct);
  }
  Future<FutureOr<void>> _updateProduct(
      UpdateProductEvent event, Emitter<UpdateProductState> emit) async {
    emit(UpdateProductLoading());

    try {
      DataResponse response =
          await ApiProvider.updateProduct(event.id, event.payload);
      if (response.statusCode == 200) {
        emit(UpdateProductLoaded(response.data));
      } else {
        emit(UpdateProductError(
            response.statusMessage ?? "Une erreur s'est produite"));
      }
    } catch (e) {
      emit(UpdateProductError(e.toString()));
    }
  }
}
