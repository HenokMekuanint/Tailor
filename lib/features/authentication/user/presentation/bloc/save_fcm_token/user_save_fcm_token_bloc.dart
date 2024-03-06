import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/usecases/save_fcm_token.dart';

part 'user_save_fcm_token_event.dart';
part 'user_save_fcm_token_state.dart';

class UserSaveFcmTokenBloc
    extends Bloc<UserSaveFcmTokenEvent, UserSaveFcmTokenState> {
  final UserSaveFcmTokenUseCase saveFcmTokenUseCase;
  UserSaveFcmTokenBloc({required this.saveFcmTokenUseCase})
      : super(UserSaveFcmTokenInitialState()) {
    on<SaveUserFcmTokenEvent>(_handleSaveFcmTokenEvent);
  }

  FutureOr<void> _handleSaveFcmTokenEvent(
      SaveUserFcmTokenEvent event, Emitter<UserSaveFcmTokenState> emit) async {
    emit(UserSaveFcmTokenLoadingState());
    final result = await saveFcmTokenUseCase(event.fcmToken);
    result.fold(
      (failure) => emit(UserSaveFcmTokenErrorState(message: failure.message)),
      (user) => emit(UserSaveFcmTokenLoadedState(user: user)),
    );
  }
}
