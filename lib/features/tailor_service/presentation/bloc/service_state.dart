part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ServiceInitialState extends ServiceState {}

final class ServiceLoadingState extends ServiceState {}

final class ServiceSuccessState extends ServiceState {
  final ServiceEntity service;
  ServiceSuccessState({required this.service});
}

final class ServiceFailureState extends ServiceState {
  final String failureMessage;
  ServiceFailureState({required this.failureMessage});
}

final class DeleteServiceSuccessState extends ServiceState {}

final class GetServicesSuccessState extends ServiceState {
  final List<ServiceEntity> services;
  GetServicesSuccessState({required this.services});
}
