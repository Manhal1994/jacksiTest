import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jacksi_test/data/repository.dart';
import '../../../../../data/database/database.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Repository repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if(event is GetCategoryEvent){
        emit(CategoryLoading());
        try {
          final categories = await repository.getCategories();
          emit(CategoryLoaded(categories));
        }
        on Exception catch(e){
          emit(CategoryFail());

        }
      }
    });
  }
}
