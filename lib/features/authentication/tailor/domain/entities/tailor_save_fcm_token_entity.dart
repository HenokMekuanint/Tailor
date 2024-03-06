import 'package:equatable/equatable.dart';

class TailorSaveFcmTokenEntity extends Equatable {
  final String fcmToken;

  final String user_type;

  TailorSaveFcmTokenEntity({
    required this.fcmToken,
    this.user_type = 'tailor',
  }) : super();

  @override
  List<Object> get props => [fcmToken, user_type];
}
