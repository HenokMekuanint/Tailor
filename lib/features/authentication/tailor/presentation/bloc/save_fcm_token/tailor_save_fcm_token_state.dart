part of 'tailor_save_fcm_token_bloc.dart';

@immutable
sealed class TailorSaveFcmTokenState extends Equatable {
  const TailorSaveFcmTokenState();

  @override
  List<Object> get props => [];
}

final class TailorSaveFcmTokenInitialState extends TailorSaveFcmTokenState {}

final class TailorSaveFcmTokenLoadingState extends TailorSaveFcmTokenState {}

final class TailorSaveFcmTokenLoadedState extends TailorSaveFcmTokenState {
  final Tailor tailor;

  TailorSaveFcmTokenLoadedState({required this.tailor});

  @override
  List<Object> get props => [tailor];
}

final class TailorSaveFcmTokenErrorState extends TailorSaveFcmTokenState {
  final String message;

  TailorSaveFcmTokenErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
