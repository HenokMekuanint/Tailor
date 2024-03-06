part of 'tailor_update_profile_pic_bloc.dart';

sealed class TailorUpdateProfilePicEvent extends Equatable {
  const TailorUpdateProfilePicEvent();

  @override
  List<Object> get props => [];
}

class TailorUpdateProfilePicEventStarted extends TailorUpdateProfilePicEvent {
  final XFile myFile;

  TailorUpdateProfilePicEventStarted({required this.myFile});
  @override
  List<Object> get props => [myFile];
}
