// ignore_for_file: non_constant_identifier_names

part of 'tailor_auth_bloc.dart';

abstract class TailorAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpTailorEvent extends TailorAuthEvent {
  final Tailor tailor;
  SignUpTailorEvent({required this.tailor});
}

class SignInTailorEvent extends TailorAuthEvent {
  final TailorLogin tailor;
  SignInTailorEvent({required this.tailor});
}

class SignOutTailorEvent extends TailorAuthEvent {
  final String user_type;
  SignOutTailorEvent({required this.user_type});
}

class UpdateProfileEvent extends TailorAuthEvent {
  final TailorUpdateProfileEntity tailorUpdateProfileEntity;
  UpdateProfileEvent({required this.tailorUpdateProfileEntity});
}

class GetLoggedInTailorInfoEvent extends TailorAuthEvent {}
