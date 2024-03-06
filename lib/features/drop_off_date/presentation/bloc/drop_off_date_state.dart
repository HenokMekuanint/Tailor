part of 'drop_off_date_bloc.dart';

sealed class DropOffDateState extends Equatable {
  const DropOffDateState();

  @override
  List<Object> get props => [];
}

final class DropOffDateInitialState extends DropOffDateState {}

final class DropOffDateLoadingState extends DropOffDateState {}

final class DropOffDateErrorState extends DropOffDateState {
  final String message;

  const DropOffDateErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetDropOffDatesSuccessState extends DropOffDateState {
  final List<DropOffDateEntity> dropOffDateEntities;

  const GetDropOffDatesSuccessState({
    required this.dropOffDateEntities,
  });

  @override
  List<Object> get props => [dropOffDateEntities];
}

final class CreateDropOffDateSuccessState extends DropOffDateState {
  final DropOffDateEntity dropOffDateEntity;

  const CreateDropOffDateSuccessState({required this.dropOffDateEntity});

  @override
  List<Object> get props => [DropOffDateEntity];
}

final class DeleteDropOffDateSuccessState extends DropOffDateState {
  final DeleteDropOffDateResponse deleteDropOffDateResponse;

  const DeleteDropOffDateSuccessState(
      {required this.deleteDropOffDateResponse});

  @override
  List<Object> get props => [deleteDropOffDateResponse];
}

final class UpdateDropOffDateSuccessState extends DropOffDateState {
  final DropOffDateEntity dropOffDateEntity;

  const UpdateDropOffDateSuccessState({required this.dropOffDateEntity});

  @override
  List<Object> get props => [dropOffDateEntity];
}

final class GetDropOffDateSuccessState extends DropOffDateState {
  final DropOffDateEntity dropOffDateEntity;

  const GetDropOffDateSuccessState({required this.dropOffDateEntity});

  @override
  List<Object> get props => [dropOffDateEntity];
}
