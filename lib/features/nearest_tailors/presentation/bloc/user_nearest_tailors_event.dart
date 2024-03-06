part of 'user_nearest_tailors_bloc.dart';

sealed class UserNearestTailorsEvent extends Equatable {
  const UserNearestTailorsEvent();

  @override
  List<Object> get props => [];
}

class GetNearestTailorsEvent extends UserNearestTailorsEvent {
  final GetNearestTailorsRequestModel getNearestTailorsRequestModel;

  const GetNearestTailorsEvent({required this.getNearestTailorsRequestModel});

  @override
  List<Object> get props => [getNearestTailorsRequestModel];
}

class GetNearestTailorDetailEvent extends UserNearestTailorsEvent {
  final GetNearestTailorRequestModel getNearestTailorRequestModel;

  const GetNearestTailorDetailEvent(
      {required this.getNearestTailorRequestModel});

  @override
  List<Object> get props => [getNearestTailorRequestModel];
}
