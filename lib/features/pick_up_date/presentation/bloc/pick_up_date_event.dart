part of 'pick_up_date_bloc.dart';

sealed class PickUpDateEvent extends Equatable {
  const PickUpDateEvent();

  @override
  List<Object> get props => [];
}

class GetPickUpDatesEvent extends PickUpDateEvent {
  const GetPickUpDatesEvent();

  @override
  List<Object> get props => [];
}

class CreatePickUpDateEvent extends PickUpDateEvent {
  final CreatePickUpDateEntity createPickUpDateEntity;

  const CreatePickUpDateEvent({required this.createPickUpDateEntity});

  @override
  List<Object> get props => [createPickUpDateEntity];
}

class DeletePickUpDateEvent extends PickUpDateEvent {
  final int id;

  const DeletePickUpDateEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdatePickUpDateEvent extends PickUpDateEvent {
  final PickUpDateEntity pickUpDateEntity;

  const UpdatePickUpDateEvent({required this.pickUpDateEntity});

  @override
  List<Object> get props => [pickUpDateEntity];
}

class GetPickUpDateEvent extends PickUpDateEvent {
  final int id;

  const GetPickUpDateEvent({required this.id});

  @override
  List<Object> get props => [id];
}
