part of 'tailor_auth_bloc.dart';

abstract class TailorAuthState extends Equatable {
  const TailorAuthState();

  @override
  List<Object?> get props => [];
}

class TailorAuthInitialState extends TailorAuthState {}

class TailorAuthLoadingState extends TailorAuthState {}

// SignUP States
class SignUpSuccessState extends TailorAuthState {
  final Tailor tailor;

  const SignUpSuccessState({required this.tailor});

  @override
  List<Object?> get props => [tailor];
}

class SignUpFailureState extends TailorAuthState {
  final String errormessage;

  const SignUpFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

// Sign In States

class SignInLoadingState extends TailorAuthState {}

class SignInSuccessState extends TailorAuthState {
  final Tailor tailor;

  const SignInSuccessState({required this.tailor});

  @override
  List<Object?> get props => [tailor];
}

class SignInFailureState extends TailorAuthState {
  final String errormessage;

  const SignInFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

// Sign Out States
class SignOutLoadingState extends TailorAuthState {}

class SignOutSuccessState extends TailorAuthState {}

class SignOutFailureState extends TailorAuthState {
  final String errormessage;

  const SignOutFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

class UpdateProfileLoadingState extends TailorAuthState {}

class UpdateProfileSuccessState extends TailorAuthState {
  final Tailor tailor;

  const UpdateProfileSuccessState({required this.tailor});

  @override
  List<Object?> get props => [tailor];
}

class UpdateProfileFailureState extends TailorAuthState {
  final String errormessage;

  const UpdateProfileFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}

class GetLoggedInTailorInfoLoadingState extends TailorAuthState {}

class GetLoggedInTailorInfoSuccessState extends TailorAuthState {
  final Tailor tailor;

  const GetLoggedInTailorInfoSuccessState({required this.tailor});

  @override
  List<Object?> get props => [tailor];
}

class GetLoggedInTailorInfoFailureState extends TailorAuthState {
  final String errormessage;

  const GetLoggedInTailorInfoFailureState({required this.errormessage});
  @override
  List<Object?> get props => [errormessage];
}
