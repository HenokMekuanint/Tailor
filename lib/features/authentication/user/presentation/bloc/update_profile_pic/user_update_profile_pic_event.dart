part of 'user_update_profile_pic_bloc.dart';

sealed class UserUpdateProfilePicEvent extends Equatable {
  const UserUpdateProfilePicEvent();

  @override
  List<Object> get props => [];
}

class UserUpdateProfilePicEventStarted extends UserUpdateProfilePicEvent {
  final XFile imageFile;

  UserUpdateProfilePicEventStarted({required this.imageFile});
  @override
  List<Object> get props => [imageFile];
}
