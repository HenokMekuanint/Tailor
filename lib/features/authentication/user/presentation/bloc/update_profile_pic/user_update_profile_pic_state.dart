part of 'user_update_profile_pic_bloc.dart';

sealed class UserUpdateProfilePicState extends Equatable {
  const UserUpdateProfilePicState();

  @override
  List<Object> get props => [];
}

final class UserUpdateProfilePicInitialState
    extends UserUpdateProfilePicState {}

final class UserUpdateProfilePicLoadingState
    extends UserUpdateProfilePicState {}

final class UserUpdateProfilePicSuccessState extends UserUpdateProfilePicState {
  final User user;

  UserUpdateProfilePicSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}

final class UserUpdateProfilePicErrorState extends UserUpdateProfilePicState {
  final String message;

  UserUpdateProfilePicErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
