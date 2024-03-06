part of 'user_save_fcm_token_bloc.dart';

@immutable
sealed class UserSaveFcmTokenState extends Equatable {
  const UserSaveFcmTokenState();

  @override
  List<Object> get props => [];
}

final class UserSaveFcmTokenInitialState extends UserSaveFcmTokenState {}

final class UserSaveFcmTokenLoadingState extends UserSaveFcmTokenState {}

final class UserSaveFcmTokenLoadedState extends UserSaveFcmTokenState {
  final User user;

  UserSaveFcmTokenLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

final class UserSaveFcmTokenErrorState extends UserSaveFcmTokenState {
  final String message;

  UserSaveFcmTokenErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
