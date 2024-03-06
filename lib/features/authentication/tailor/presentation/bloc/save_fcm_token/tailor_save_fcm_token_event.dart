part of 'tailor_save_fcm_token_bloc.dart';

@immutable
sealed class TailorSaveFcmTokenEvent extends Equatable {}

class SaveTailorFcmTokenEvent extends TailorSaveFcmTokenEvent {
  final String fcmToken;

  SaveTailorFcmTokenEvent({required this.fcmToken});

  @override
  List<Object> get props => [fcmToken];
}
