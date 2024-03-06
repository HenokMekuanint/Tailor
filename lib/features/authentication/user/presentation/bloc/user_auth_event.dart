// ignore_for_file: non_constant_identifier_names

part of 'user_auth_bloc.dart';

abstract class UserAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpUserEvent extends UserAuthEvent {
  final User user;
  SignUpUserEvent({required this.user});
}

class SignInUserEvent extends UserAuthEvent {
  final UserLogin user;
  SignInUserEvent({required this.user});
}

class SignOutUserEvent extends UserAuthEvent {
  final String user_type;
  SignOutUserEvent({required this.user_type});
}

class UpdateProfileUserEvent extends UserAuthEvent {
  final UserUpdateProfileEntity userUpdateProfileEntity;
  UpdateProfileUserEvent({required this.userUpdateProfileEntity});
}

class GetLoggedInUserInfoEvent extends UserAuthEvent {}
