part of 'search_nearest_tailors_bloc.dart';

sealed class SearchNearestTailorsEvent extends Equatable {
  const SearchNearestTailorsEvent();

  @override
  List<Object> get props => [];
}

class SearchNearestTailorsByAddressEvent extends SearchNearestTailorsEvent {
  final SearchNearestTailorsByAddressRequestModel
      searchModel;

  SearchNearestTailorsByAddressEvent(
      {required this.searchModel});
}
