import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/update_profile_picture.dart';

part 'tailor_update_profile_pic_event.dart';
part 'tailor_update_profile_pic_state.dart';

class TailorUpdateProfilePicBloc
    extends Bloc<TailorUpdateProfilePicEvent, TailorUpdateProfilePicState> {
  final TailorUpdateProfilePictureUseCase tailorUpdateProfilePictureUseCase;

  TailorUpdateProfilePicBloc({required this.tailorUpdateProfilePictureUseCase})
      : super(TailorUpdateProfilePicInitialState()) {
    on<TailorUpdateProfilePicEventStarted>(_handleTailorUpdateProfilePicEvent);
  }

  FutureOr<void> _handleTailorUpdateProfilePicEvent(
      TailorUpdateProfilePicEventStarted event,
      Emitter<TailorUpdateProfilePicState> emit) async {
    emit(TailorUpdateProfilePicLoadingState());
    final result = await tailorUpdateProfilePictureUseCase(event.myFile);

    result.fold(
        (failure) =>
            emit(TailorUpdateProfilePicErrorState(message: failure.message)),
        (success) => emit(TailorUpdateProfilePicSuccessState(tailor: success)));
  }
}
