import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/IDataResponse.dart';
import '../../services/ApiProvider.dart';

part '../events/list_product_event.dart';

part '../states/list_product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitilaState()) {
    on<ProductLoadedEvent>(_productLoadEvent);
  }

  Future<FutureOr<void>> _productLoadEvent(
      ProductLoadedEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      DataResponse<dynamic> response = await ApiProvider.getProductsList();

      if (response.statusCode == 200) {
        emit(ProductLoaded(response.data));
      } else {
        emit(ProductError(
            response.statusMessage ?? "Une erreur s'est produite"));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
