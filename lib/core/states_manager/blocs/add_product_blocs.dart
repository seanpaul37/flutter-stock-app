import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/IDataResponse.dart';
import '../../services/ApiProvider.dart';

part '../events/add_product_events.dart';
part '../states/add_product_state.dart';

class AddProductBloc extends Bloc<AddProductBlocEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitilaState()) {
    on<AddProductEvent>(_addProduct);
    // on<DeleteProductEvent>(_deleteProduct);
  }
  Future<FutureOr<void>> _addProduct(
      AddProductEvent event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());

    try {
      DataResponse response = await ApiProvider.addProduct(event.payload);
      if (response.statusCode == 200) {
        emit(AddProductLoaded(response.data));
      } else {
        emit(AddProductError(
            response.statusMessage ?? "Une erreur s'est produite"));
      }
    } catch (e) {
      emit(AddProductError(e.toString()));
    }
  }

  // Future<FutureOr<void>> _deleteProduct(
  //     DeleteProductEvent event, Emitter<ClassProductBlocState> emit) async {
  //   emit(ClassProductLoading());

  //   try {
  //     DataResponse response =
  //         await ApiProvider().deleteProduct(event.ProductId);
  //     if (response.statusCode == 200) {
  //       emit(ClassProductLoaded(response.data));
  //     } else
  //       emit(ClassProductError(
  //           response.statusMessage ?? "Une erreur s'est produite"));
  //     ;
  //   } catch (e) {
  //     emit(ClassProductError(e.toString()));
  //   }
  // }
}
