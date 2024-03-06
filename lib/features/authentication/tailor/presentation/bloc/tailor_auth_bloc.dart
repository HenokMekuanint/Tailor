import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_login_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_update_profile_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/get_logged_in_user_info.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_in_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_out_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_up_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/update_profile_tailor.dart';

part 'tailor_auth_event.dart';
part 'tailor_auth_state.dart';

class TailorAuthBloc extends Bloc<TailorAuthEvent, TailorAuthState> {
  final SignUpTailor signUpTailor;
  final SignInTailor signInTailor;
  final SignOutTailor signOutTailor;
  final UpdateProfileTailor updateProfileTailor;
  final GetLoggedInTailorInfoLocal getLoggedInTailorInfoLocal;

  TailorAuthState signInSuccessOrFailure(Either<Failure, Tailor> data) {
    return data.fold(
      (failure) => SignInFailureState(errormessage: failure.message),
      (success) => SignInSuccessState(tailor: success),
    );
  }

  TailorAuthState signUpSuccessOrFailure(Either<Failure, Tailor> data) {
    return data.fold(
      (failure) => SignUpFailureState(errormessage: failure.message),
      (success) => SignUpSuccessState(tailor: success),
    );
  }

  TailorAuthState signOutSuccessOrFailure(Either<Failure, String> data) {
    return data.fold(
      (failure) => SignOutFailureState(errormessage: failure.message),
      (success) => SignOutSuccessState(),
    );
  }

  void _signUpTailor(
      SignUpTailorEvent event, Emitter<TailorAuthState> emit) async {
    emit(TailorAuthLoadingState());
    final result = await signUpTailor(event.tailor);
    emit(signUpSuccessOrFailure(result));
  }

  void _signInUser(
      SignInTailorEvent event, Emitter<TailorAuthState> emit) async {
    emit(SignInLoadingState());
    final result = await signInTailor(event.tailor);
    emit(signInSuccessOrFailure(result));
  }

  void _signOutUser(
      SignOutTailorEvent event, Emitter<TailorAuthState> emit) async {
    emit(SignOutLoadingState());
    final result = await signOutTailor(event.user_type);

    emit(signOutSuccessOrFailure(result));
  }

  TailorAuthBloc({
    required this.signInTailor,
    required this.signOutTailor,
    required this.signUpTailor,
    required this.updateProfileTailor,
    required this.getLoggedInTailorInfoLocal,
  }) : super(TailorAuthInitialState()) {
    on<SignUpTailorEvent>(_signUpTailor);
    on<SignInTailorEvent>(_signInUser);
    on<SignOutTailorEvent>(_signOutUser);
    on<UpdateProfileEvent>(_updateProfile);
    on<GetLoggedInTailorInfoEvent>(_getLoggedInUserInfo);
  }

  Future<void> _updateProfile(
      UpdateProfileEvent event, Emitter<TailorAuthState> emit) async {
    emit(UpdateProfileLoadingState());
    final result = await updateProfileTailor(event.tailorUpdateProfileEntity);

    result.fold(
        (failure) =>
            emit(UpdateProfileFailureState(errormessage: failure.message)),
        (success) => emit(UpdateProfileSuccessState(tailor: success)));
  }

  Future<void> _getLoggedInUserInfo(
      GetLoggedInTailorInfoEvent event, Emitter<TailorAuthState> emit) async {
    emit(GetLoggedInTailorInfoLoadingState());
    final result = await getLoggedInTailorInfoLocal();
    result.fold(
        (failure) => emit(
            GetLoggedInTailorInfoFailureState(errormessage: failure.message)),
        (success) => emit(GetLoggedInTailorInfoSuccessState(tailor: success)));
  }
}
