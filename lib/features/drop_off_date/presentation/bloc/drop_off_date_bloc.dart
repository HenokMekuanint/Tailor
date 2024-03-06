import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/drop_off_date/domain/entities/create_drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/entities/delete_drop_of_date_response.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/create_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/delete_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/get_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/get_drop_off_dates.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/update_drop_off_date.dart';

part 'drop_off_date_event.dart';
part 'drop_off_date_state.dart';

class DropOffDateBloc extends Bloc<DropOffDateEvent, DropOffDateState> {
  final GetDropOffDatesUseCase getDropOffDatesUseCase;
  final CreateDropOffDateUseCase createDropOffDateUseCase;
  final UpdateDropOffDateUseCase updateDropOffDateUseCase;
  final DeleteDropOffDateUseCase deleteDropOffDateUseCase;
  final GetDropOffDateUseCase getDropOffDateUseCase;
  DropOffDateBloc(
      {required this.getDropOffDatesUseCase,
      required this.createDropOffDateUseCase,
      required this.updateDropOffDateUseCase,
      required this.deleteDropOffDateUseCase,
      required this.getDropOffDateUseCase})
      : super(DropOffDateInitialState()) {
    on<GetDropOffDatesEvent>(_handleGetDropOffDatesEvent);
    on<CreateDropOffDateEvent>(_handleCreateDropOffDateEvent);
    on<UpdateDropOffDateEvent>(_handleUpdateDropOffDateEvent);
    on<DeleteDropOffDateEvent>(_handleDeleteDropOffDateEvent);
    on<GetDropOffDateEvent>(_handleGetDropOffDateEvent);
  }

  Future<void> _handleGetDropOffDatesEvent(
      GetDropOffDatesEvent event, Emitter<DropOffDateState> emit) async {
    emit(DropOffDateLoadingState());
    final result = await getDropOffDatesUseCase(NoParams());
    result.fold(
      (failure) => emit(DropOffDateErrorState(message: failure.message)),
      (success) =>
          emit(GetDropOffDatesSuccessState(dropOffDateEntities: success)),
    );
  }

  Future<void> _handleCreateDropOffDateEvent(
      CreateDropOffDateEvent event, Emitter<DropOffDateState> emit) async {
    emit(DropOffDateLoadingState());
    final result = await createDropOffDateUseCase(
        CreateDropOffDateParams(dropOffDate: event.createDropOffDateEntity));

    result.fold(
      (failure) => emit(DropOffDateErrorState(message: failure.message)),
      (success) =>
          emit(CreateDropOffDateSuccessState(dropOffDateEntity: success)),
    );
  }

  Future<void> _handleUpdateDropOffDateEvent(
      UpdateDropOffDateEvent event, Emitter<DropOffDateState> emit) async {
    emit(DropOffDateLoadingState());
    final result = await updateDropOffDateUseCase(
        UpdateDropOffDateParams(dropOffDate: event.dropOffDateEntity));

    result.fold(
      (failure) => emit(DropOffDateErrorState(message: failure.message)),
      (success) =>
          emit(UpdateDropOffDateSuccessState(dropOffDateEntity: success)),
    );
  }

  Future<void> _handleDeleteDropOffDateEvent(
      DeleteDropOffDateEvent event, Emitter<DropOffDateState> emit) async {
    emit(DropOffDateLoadingState());
    final result =
        await deleteDropOffDateUseCase(DeleteDropOffDateParams(id: event.id));

    result.fold(
      (failure) => emit(DropOffDateErrorState(message: failure.message)),
      (success) => emit(
          DeleteDropOffDateSuccessState(deleteDropOffDateResponse: success)),
    );
  }

  Future<void> _handleGetDropOffDateEvent(
      GetDropOffDateEvent event, Emitter<DropOffDateState> emit) async {
    emit(DropOffDateLoadingState());
    final result =
        await getDropOffDateUseCase(GetDropOffDateParams(id: event.id));

    result.fold(
      (failure) => emit(DropOffDateErrorState(message: failure.message)),
      (success) => emit(GetDropOffDateSuccessState(dropOffDateEntity: success)),
    );
  }
}
