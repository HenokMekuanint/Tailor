import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/save_fcm_token.dart';

part 'tailor_save_fcm_token_event.dart';
part 'tailor_save_fcm_token_state.dart';

class TailorSaveFcmTokenBloc
    extends Bloc<TailorSaveFcmTokenEvent, TailorSaveFcmTokenState> {
  final TailorSaveFcmTokenUseCase saveFcmTokenUseCase;
  TailorSaveFcmTokenBloc({required this.saveFcmTokenUseCase})
      : super(TailorSaveFcmTokenInitialState()) {
    on<SaveTailorFcmTokenEvent>(_handleSaveFcmTokenEvent);
  }

  FutureOr<void> _handleSaveFcmTokenEvent(SaveTailorFcmTokenEvent event,
      Emitter<TailorSaveFcmTokenState> emit) async {
    emit(TailorSaveFcmTokenLoadingState());
    final result = await saveFcmTokenUseCase(event.fcmToken);
    result.fold(
      (failure) => emit(TailorSaveFcmTokenErrorState(message: failure.message)),
      (tailor) => emit(TailorSaveFcmTokenLoadedState(tailor: tailor)),
    );
  }
}
