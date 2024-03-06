import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/domain/usecases/create_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/delete_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/edit_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/get_services.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final CreateService createService;
  final EditService editService;
  final DeleteService deleteService;
  final GetServices getServices;

  // Create and Edit Service state handler.
  ServiceState serviceSuccessOrFailure(Either<Failure, ServiceEntity> data) {
    return data.fold(
      (failure) => ServiceFailureState(failureMessage: failure.message),
      (success) => ServiceSuccessState(service: success),
    );
  }

  // Delete Service state handler.
  ServiceState deleteServiceSuccessOrFailure(Either<Failure, bool> data) {
    return data.fold(
      (failure) => ServiceFailureState(failureMessage: failure.message),
      (success) => DeleteServiceSuccessState(),
    );
  }

  // get services state handler 
  ServiceState getServicesSuccessOrFailure(Either<Failure, List<ServiceEntity>> data) {
    return data.fold(
      (failure) => ServiceFailureState(failureMessage: failure.message),
      (success) => GetServicesSuccessState(services: success),
    );
  }

  void _createService(
      CreateServiceEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoadingState());
    final result = await createService(event.service);
    emit(serviceSuccessOrFailure(result));
  }

  void _editService(EditServiceEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoadingState());
    final result = await editService(event.service);
    emit(serviceSuccessOrFailure(result));
  }

  void _deleteService(
      DeleteServiceEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoadingState());
    final result = await deleteService(event.serviceId);
    emit(deleteServiceSuccessOrFailure(result));
  }

   void _getServices(
      GetServicesEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoadingState());
    final result = await getServices();
    emit(getServicesSuccessOrFailure(result));
  }


  ServiceBloc({
    required this.createService,
    required this.deleteService,
    required this.editService,
    required this.getServices
  }) : super(ServiceInitialState()) {
    on<CreateServiceEvent>(_createService);
    on<EditServiceEvent>(_editService);
    on<DeleteServiceEvent>(_deleteService);
    on<GetServicesEvent>(_getServices);
  }
}
