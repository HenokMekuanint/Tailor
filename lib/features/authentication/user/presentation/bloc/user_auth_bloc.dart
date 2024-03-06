import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/tailor_auth_bloc.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';
import 'package:mobile/features/authentication/user/domain/usecases/get_logged_in_user_info.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_in_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_out_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_up_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/update_profile_user.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final SignUpUser signUpUser;
  final SignInUser signInUser;
  final SignOutUser signOutUser;
  final UpdateProfileUser updateProfileUser;
  final GetLoggedInUserInfoLocal getLoggedInUserInfoLocal;

  UserAuthBloc({
    required this.signInUser,
    required this.signOutUser,
    required this.signUpUser,
    required this.updateProfileUser,
    required this.getLoggedInUserInfoLocal,
  }) : super(UserAuthInitialState()) {
    on<SignUpUserEvent>(_signUpUser);
    on<SignInUserEvent>(_signInUser);
    on<SignOutUserEvent>(_signOutUser);
    on<UpdateProfileUserEvent>(_updateProfileUser);
    on<GetLoggedInUserInfoEvent>(_getLoggedInUserInfo);
  }

  UserAuthState signInSuccessOrFailure(Either<Failure, User> data) {
    return data.fold(
      (failure) => SignInFailureState(errormessage: failure.message),
      (success) => SignInSuccessState(user: success),
    );
  }

  UserAuthState signUpSuccessOrFailure(Either<Failure, User> data) {
    return data.fold(
      (failure) => SignUpFailureState(errormessage: failure.message),
      (success) => SignUpSuccessState(user: success),
    );
  }

  UserAuthState signOutSuccessOrFailure(Either<Failure, String> data) {
    return data.fold(
      (failure) => SignOutFailureState(errormessage: failure.message),
      (success) => SignOutSuccessState(),
    );
  }

  void _signUpUser(SignUpUserEvent event, Emitter<UserAuthState> emit) async {
    emit(UserAuthLoadingState());
    final result = await signUpUser(event.user);
    emit(signUpSuccessOrFailure(result));
  }

  void _signInUser(SignInUserEvent event, Emitter<UserAuthState> emit) async {
    emit(UserAuthLoadingState());
    final result = await signInUser(event.user);
    emit(signInSuccessOrFailure(result));
  }

  void _signOutUser(SignOutUserEvent event, Emitter<UserAuthState> emit) async {
    emit(SignOutLoadingState());
    final result = await signOutUser(event.user_type);
    emit(signOutSuccessOrFailure(result));
  }

  Future<void> _updateProfileUser(
      UpdateProfileUserEvent event, Emitter<UserAuthState> emit) async {
    emit(UpdateProfileLoadingState());
    final result = await updateProfileUser(event.userUpdateProfileEntity);
    result.fold(
        (failure) =>
            emit(UpdateProfileFailureState(errormessage: failure.message)),
        (success) => emit(UpdateProfileSuccessState(user: success)));
  }

  Future<void> _getLoggedInUserInfo(
      GetLoggedInUserInfoEvent event, Emitter<UserAuthState> emit) async {
    emit(GetLoggedInUserInfoLoadingState());
    final result = await getLoggedInUserInfoLocal();
    result.fold(
        (failure) => emit(
            GetLoggedInUserInfoFailureState(errormessage: failure.message)),
        (success) => emit(GetLoggedInUserInfoSuccessState(user: success)));
  }
}
