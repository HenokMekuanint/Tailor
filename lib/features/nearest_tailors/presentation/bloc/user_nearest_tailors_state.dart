part of 'user_nearest_tailors_bloc.dart';

sealed class UserNearestTailorsState extends Equatable {
  const UserNearestTailorsState();

  @override
  List<Object> get props => [];
}

final class UserNearestTailorsInitialState extends UserNearestTailorsState {}

final class UserNearestTailorsLoadingState extends UserNearestTailorsState {}

final class UserNearestTailorsLoadedSuccessState
    extends UserNearestTailorsState {
  final NearestTailors nearestTailors;

  const UserNearestTailorsLoadedSuccessState({required this.nearestTailors});

  @override
  List<Object> get props => [nearestTailors];
}

final class UserNearestTailorsErrorState extends UserNearestTailorsState {
  final String message;

  const UserNearestTailorsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserNearestTailorDetailLoadingState
    extends UserNearestTailorsState {}

final class UserNearestTailorDetailLoadedSuccessState
    extends UserNearestTailorsState {
  final NearestTailorDetail nearestTailor;

  const UserNearestTailorDetailLoadedSuccessState(
      {required this.nearestTailor});

  @override
  List<Object> get props => [nearestTailor];
}

final class UserNearestTailorDetailErrorState extends UserNearestTailorsState {
  final String message;

  const UserNearestTailorDetailErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
