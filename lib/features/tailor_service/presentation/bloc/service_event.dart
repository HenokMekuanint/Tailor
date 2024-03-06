part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateServiceEvent extends ServiceEvent {
  final ServiceEntity service;
  CreateServiceEvent({required this.service});
}

class EditServiceEvent extends ServiceEvent {
  final ServiceEntity service;
  EditServiceEvent({required this.service});
}

class GetServicesEvent extends ServiceEvent {}

class DeleteServiceEvent extends ServiceEvent {
  final String serviceId;
  DeleteServiceEvent({required this.serviceId});
}
