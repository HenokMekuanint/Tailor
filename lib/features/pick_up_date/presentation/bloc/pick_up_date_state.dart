part of 'pick_up_date_bloc.dart';

sealed class PickUpDateState extends Equatable {
  const PickUpDateState();

  @override
  List<Object> get props => [];
}

final class PickUpDateInitialState extends PickUpDateState {}

final class PickUpDateLoadingState extends PickUpDateState {}

final class PickUpDateErrorState extends PickUpDateState {
  final String message;

  const PickUpDateErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetPickUpDatesSuccessState extends PickUpDateState {
  final List<PickUpDateEntity> pickUpDateEntities;

  const GetPickUpDatesSuccessState({
    required this.pickUpDateEntities,
  });

  @override
  List<Object> get props => [pickUpDateEntities];
}

final class CreatePickUpDateSuccessState extends PickUpDateState {
  final PickUpDateEntity pickUpDateEntity;

  const CreatePickUpDateSuccessState({required this.pickUpDateEntity});

  @override
  List<Object> get props => [pickUpDateEntity];
}

final class DeletePickUpDateSuccessState extends PickUpDateState {
  final DeletePickUpDateResponse deletePickUpDateResponse;

  const DeletePickUpDateSuccessState({required this.deletePickUpDateResponse});

  @override
  List<Object> get props => [deletePickUpDateResponse];
}

final class UpdatePickUpDateSuccessState extends PickUpDateState {
  final PickUpDateEntity pickUpDateEntity;

  const UpdatePickUpDateSuccessState({required this.pickUpDateEntity});

  @override
  List<Object> get props => [pickUpDateEntity];
}

final class GetPickUpDateSuccessState extends PickUpDateState {
  final PickUpDateEntity pickUpDateEntity;

  const GetPickUpDateSuccessState({required this.pickUpDateEntity});

  @override
  List<Object> get props => [pickUpDateEntity];
}
