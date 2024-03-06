import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailor_detail_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailors_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailors.dart';
import 'package:mobile/features/nearest_tailors/data/repositories/nearest_tailor_repo.dart';

part 'user_nearest_tailors_event.dart';
part 'user_nearest_tailors_state.dart';

class UserNearestTailorsBloc
    extends Bloc<UserNearestTailorsEvent, UserNearestTailorsState> {
  UserNearestTailorsBloc({required this.nearestTailorsRepository})
      : super(UserNearestTailorsInitialState()) {
    on<GetNearestTailorsEvent>(_handleGetNearestTailorsEvent);
    on<GetNearestTailorDetailEvent>(_handleGetNearestTailorDetailEvent);
  }

  final NearestTailorsRepository nearestTailorsRepository;

  Future<void> _handleGetNearestTailorsEvent(GetNearestTailorsEvent event,
      Emitter<UserNearestTailorsState> emit) async {
    emit(UserNearestTailorsLoadingState());

    final nearestTailors = await nearestTailorsRepository
        .getNearestTailors(event.getNearestTailorsRequestModel);

    nearestTailors.fold(
        (failure) =>
            emit(UserNearestTailorsErrorState(message: failure.message)),
        (tailors) => emit(
            UserNearestTailorsLoadedSuccessState(nearestTailors: tailors)));
  }

  Future<void> _handleGetNearestTailorDetailEvent(
      GetNearestTailorDetailEvent event,
      Emitter<UserNearestTailorsState> emit) async {
    emit(UserNearestTailorDetailLoadingState());

    final nearestTailorDetail = await nearestTailorsRepository
        .getNearestTailorDetails(event.getNearestTailorRequestModel);

    nearestTailorDetail.fold(
        (failure) =>
            emit(UserNearestTailorDetailErrorState(message: failure.message)),
        (tailorDetail) => emit(UserNearestTailorDetailLoadedSuccessState(
            nearestTailor: tailorDetail)));
  }
}
