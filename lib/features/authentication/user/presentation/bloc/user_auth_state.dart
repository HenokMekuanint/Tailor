part of 'user_auth_bloc.dart';

abstract class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object?> get props => [];
}

class UserAuthInitialState extends UserAuthState {}

class UserAuthLoadingState extends UserAuthState {}

// SignUP States
class SignUpSuccessState extends UserAuthState {
  final User user;

  const SignUpSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignUpFailureState extends UserAuthState {
  final String errormessage;

  const SignUpFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

// Sign In States
class SignInSuccessState extends UserAuthState {
  final User user;

  const SignInSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignInFailureState extends UserAuthState {
  final String errormessage;

  const SignInFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

// Sign Out States
class SignOutSuccessState extends UserAuthState {}

class SignOutFailureState extends UserAuthState {
  final String errormessage;

  const SignOutFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

class SignOutLoadingState extends UserAuthState {}

class UpdateProfileSuccessState extends UserAuthState {
  final User user;

  const UpdateProfileSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateProfileFailureState extends UserAuthState {
  final String errormessage;

  const UpdateProfileFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

class UpdateProfileLoadingState extends UserAuthState {}

class GetLoggedInUserInfoSuccessState extends UserAuthState {
  final User user;

  const GetLoggedInUserInfoSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetLoggedInUserInfoFailureState extends UserAuthState {
  final String errormessage;

  const GetLoggedInUserInfoFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

class GetLoggedInUserInfoLoadingState extends UserAuthState {}
