import 'package:bloc/bloc.dart';
import 'package:jacksi_test/data/dto/product_dto.dart';
import 'package:meta/meta.dart';

import '../../../../../data/repository.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final Repository repository;

  AddProductBloc(this.repository) : super(AddProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      if (event is InsertProduct) {
        emit(AddProductLoading());
        try {
          final result = await repository.addProduct(event.productDTO);
          emit(AddProductSuccess(result));
        }  catch (e) {
          emit(AddProductFail(e.toString()));
        }
      }
    });
  }
}
