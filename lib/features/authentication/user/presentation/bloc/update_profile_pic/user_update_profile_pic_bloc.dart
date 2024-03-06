import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';

import 'package:mobile/features/authentication/user/domain/usecases/update_profile_picture.dart';

part 'user_update_profile_pic_event.dart';
part 'user_update_profile_pic_state.dart';

class UserUpdateProfilePicBloc
    extends Bloc<UserUpdateProfilePicEvent, UserUpdateProfilePicState> {
  final UserUpdateProfilePicUseCase userUpdateProfilePicUseCase;

  UserUpdateProfilePicBloc({required this.userUpdateProfilePicUseCase})
      : super(UserUpdateProfilePicInitialState()) {
    on<UserUpdateProfilePicEventStarted>(_handleUserUpdateProfilePicEvent);
  }

  FutureOr<void> _handleUserUpdateProfilePicEvent(
      UserUpdateProfilePicEventStarted event,
      Emitter<UserUpdateProfilePicState> emit) async {
    emit(UserUpdateProfilePicLoadingState());
    final result = await userUpdateProfilePicUseCase(event.imageFile);

    result.fold(
        (failure) =>
            emit(UserUpdateProfilePicErrorState(message: failure.message)),
        (success) => emit(UserUpdateProfilePicSuccessState(user: success)));
  }
}
