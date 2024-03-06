part of 'drop_off_date_bloc.dart';

sealed class DropOffDateEvent extends Equatable {
  const DropOffDateEvent();

  @override
  List<Object> get props => [];
}

class GetDropOffDatesEvent extends DropOffDateEvent {
  const GetDropOffDatesEvent();

  @override
  List<Object> get props => [];
}

class CreateDropOffDateEvent extends DropOffDateEvent {
  final CreateDropOffDateEntity createDropOffDateEntity;

  const CreateDropOffDateEvent({required this.createDropOffDateEntity});

  @override
  List<Object> get props => [createDropOffDateEntity];
}

class DeleteDropOffDateEvent extends DropOffDateEvent {
  final int id;

  const DeleteDropOffDateEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateDropOffDateEvent extends DropOffDateEvent {
  final DropOffDateEntity dropOffDateEntity;

  const UpdateDropOffDateEvent({required this.dropOffDateEntity});

  @override
  List<Object> get props => [DropOffDateEntity];
}

class GetDropOffDateEvent extends DropOffDateEvent {
  final int id;

  const GetDropOffDateEvent({required this.id});

  @override
  List<Object> get props => [id];
}
