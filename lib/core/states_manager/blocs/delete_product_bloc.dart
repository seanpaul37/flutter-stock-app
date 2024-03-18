import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/IDataResponse.dart';
import '../../services/ApiProvider.dart';

part '../events/delete_product_event.dart';
part '../states/delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductBloc() : super(DeleteProductInitilaState()) {
    on<DeleteProductLoadedEvent>(_deleteProductEvent);
  }
  Future<FutureOr<void>> _deleteProductEvent(
      DeleteProductLoadedEvent event, Emitter<DeleteProductState> emit) async {
    emit(DeleteProductLoading());

    try {
      DataResponse<dynamic> response =
          await ApiProvider.deleteProduct(event.id);

      if (response.statusCode == 200) {
        emit(DeleteProductLoaded(response.data));
      } else {
        emit(DeleteProductError(
            response.statusMessage ?? "Une erreur s'est produite"));
      }
    } catch (e) {
      emit(DeleteProductError(e.toString()));
    }
  }
}
