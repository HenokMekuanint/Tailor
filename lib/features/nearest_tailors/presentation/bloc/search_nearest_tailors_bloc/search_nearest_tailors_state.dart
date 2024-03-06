part of 'search_nearest_tailors_bloc.dart';

sealed class SearchNearestTailorsState extends Equatable {
  const SearchNearestTailorsState();
  
  @override
  List<Object> get props => [];
}

final class SearchNearestTailorsInitialState extends SearchNearestTailorsState {}

final class SearchNearestTailorsLoadingState extends SearchNearestTailorsState {}

final class SearchNearestTailorsSuccessState extends SearchNearestTailorsState {
  final NearestTailors filteredNearestTailors;

  SearchNearestTailorsSuccessState({required this.filteredNearestTailors});
}

final class SearchNearestTailorsErrorState extends SearchNearestTailorsState {
  final String message;

  SearchNearestTailorsErrorState({required this.message});
}

