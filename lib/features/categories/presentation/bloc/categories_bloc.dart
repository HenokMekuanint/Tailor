import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/categories/domain/entities/category_entity.dart';
import 'package:mobile/features/categories/domain/use_cases/get_categories_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesBloc({required this.getCategoriesUseCase})
      : super(GetCategoriesInitialState()) {
    on<GetCategoriesEvent>(_handleGetCategoriesEvent);
  }

  Future<void> _handleGetCategoriesEvent(
      GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(GetCategoriesLoadingState());
    final result = await getCategoriesUseCase.call(NoParams());
    result.fold(
      (failure) => emit(GetCategoriesErrorState(message: failure.message)),
      (categories) => emit(GetCategoriesLoadedState(categories: categories)),
    );
  }
}
