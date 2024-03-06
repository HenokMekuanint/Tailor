part of 'tailor_update_profile_pic_bloc.dart';

sealed class TailorUpdateProfilePicState extends Equatable {
  const TailorUpdateProfilePicState();

  @override
  List<Object> get props => [];
}

final class TailorUpdateProfilePicInitialState
    extends TailorUpdateProfilePicState {}

final class TailorUpdateProfilePicLoadingState
    extends TailorUpdateProfilePicState {}

final class TailorUpdateProfilePicSuccessState
    extends TailorUpdateProfilePicState {
  final Tailor tailor;

  TailorUpdateProfilePicSuccessState({required this.tailor});
  @override
  List<Object> get props => [tailor];
}

final class TailorUpdateProfilePicErrorState
    extends TailorUpdateProfilePicState {
  final String message;

  TailorUpdateProfilePicErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
