import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailors.dart';
import 'package:mobile/features/nearest_tailors/data/models/search_nearest_tailors_by_address_request_model.dart';
import 'package:mobile/features/nearest_tailors/data/repositories/nearest_tailor_repo.dart';

part 'search_nearest_tailors_event.dart';
part 'search_nearest_tailors_state.dart';

class SearchNearestTailorsBloc
    extends Bloc<SearchNearestTailorsEvent, SearchNearestTailorsState> {
  SearchNearestTailorsBloc({required this.nearestTailorsRepository})
      : super(SearchNearestTailorsInitialState()) {
    on<SearchNearestTailorsByAddressEvent>(_handleSearchNearestTailorsEvent);
  }
  final NearestTailorsRepository nearestTailorsRepository;

  FutureOr<void> _handleSearchNearestTailorsEvent(
      SearchNearestTailorsByAddressEvent event,
      Emitter<SearchNearestTailorsState> emit) async {
    emit(SearchNearestTailorsLoadingState());
    final nearestTailors = await nearestTailorsRepository
        .searchNearestTailorsByAddress(event.searchModel);
    nearestTailors.fold(
        (failure) =>
            emit(SearchNearestTailorsErrorState(message: failure.message)),
        (tailors) => emit(
            SearchNearestTailorsSuccessState(filteredNearestTailors: tailors)));
  }
}
