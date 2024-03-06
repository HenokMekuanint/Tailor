part of 'user_save_fcm_token_bloc.dart';

@immutable
sealed class UserSaveFcmTokenEvent extends Equatable {
  const UserSaveFcmTokenEvent();

  @override
  List<Object> get props => [];
}

class SaveUserFcmTokenEvent extends UserSaveFcmTokenEvent {
  final String fcmToken;

  SaveUserFcmTokenEvent({required this.fcmToken});

  @override
  List<Object> get props => [fcmToken];
}
