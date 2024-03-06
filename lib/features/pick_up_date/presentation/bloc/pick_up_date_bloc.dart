import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/delete_pick_up_date_response.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/create_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/delete_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/get_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/get_pick_up_dates.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/update_pick_up_date.dart';

part 'pick_up_date_event.dart';
part 'pick_up_date_state.dart';

class PickUpDateBloc extends Bloc<PickUpDateEvent, PickUpDateState> {
  final GetPickUpDatesUseCase getPickUpDatesUseCase;
  final CreatePickUpDateUseCase createPickUpDateUseCase;
  final UpdatePickUpDateUseCase updatePickUpDateUseCase;
  final DeletePickUpDateUseCase deletePickUpDateUseCase;
  final GetPickUpDateUseCase getPickUpDateUseCase;

  PickUpDateBloc(
      {required this.getPickUpDatesUseCase,
      required this.createPickUpDateUseCase,
      required this.updatePickUpDateUseCase,
      required this.deletePickUpDateUseCase,
      required this.getPickUpDateUseCase})
      : super(PickUpDateInitialState()) {
    on<GetPickUpDatesEvent>(_handleGetPickUpDatesEvent);
    on<CreatePickUpDateEvent>(_handleCreatePickUpDateEvent);
    on<UpdatePickUpDateEvent>(_handleUpdatePickUpDateEvent);
    on<DeletePickUpDateEvent>(_handleDeletePickUpDateEvent);
    on<GetPickUpDateEvent>(_handleGetPickUpDateEvent);
  }

  Future<void> _handleGetPickUpDatesEvent(
      GetPickUpDatesEvent event, Emitter<PickUpDateState> emit) async {
    emit(PickUpDateLoadingState());
    final result = await getPickUpDatesUseCase(NoParams());
    result.fold(
      (failure) => emit(PickUpDateErrorState(message: failure.message)),
      (success) =>
          emit(GetPickUpDatesSuccessState(pickUpDateEntities: success)),
    );
  }

  Future<void> _handleCreatePickUpDateEvent(
      CreatePickUpDateEvent event, Emitter<PickUpDateState> emit) async {
    emit(PickUpDateLoadingState());
    final result = await createPickUpDateUseCase(
        CreatePickUpDateParams(pickUpDate: event.createPickUpDateEntity));

    result.fold(
      (failure) => emit(PickUpDateErrorState(message: failure.message)),
      (success) =>
          emit(CreatePickUpDateSuccessState(pickUpDateEntity: success)),
    );
  }

  Future<void> _handleUpdatePickUpDateEvent(
      UpdatePickUpDateEvent event, Emitter<PickUpDateState> emit) async {
    emit(PickUpDateLoadingState());
    final result = await updatePickUpDateUseCase(
        UpdatePickUpDateParams(pickUpDate: event.pickUpDateEntity));

    result.fold(
      (failure) => emit(PickUpDateErrorState(message: failure.message)),
      (success) =>
          emit(UpdatePickUpDateSuccessState(pickUpDateEntity: success)),
    );
  }

  Future<void> _handleDeletePickUpDateEvent(
      DeletePickUpDateEvent event, Emitter<PickUpDateState> emit) async {
    emit(PickUpDateLoadingState());
    final result =
        await deletePickUpDateUseCase(DeletePickUpDateParams(id: event.id));

    result.fold(
      (failure) => emit(PickUpDateErrorState(message: failure.message)),
      (success) =>
          emit(DeletePickUpDateSuccessState(deletePickUpDateResponse: success)),
    );
  }

  Future<void> _handleGetPickUpDateEvent(
      GetPickUpDateEvent event, Emitter<PickUpDateState> emit) async {
    emit(PickUpDateLoadingState());
    final result =
        await getPickUpDateUseCase(GetPickUpDateParams(id: event.id));

    result.fold(
      (failure) => emit(PickUpDateErrorState(message: failure.message)),
      (success) => emit(GetPickUpDateSuccessState(pickUpDateEntity: success)),
    );
  }
}
