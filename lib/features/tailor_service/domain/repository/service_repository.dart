import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';

abstract class ServiceRepositoy {
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);
  Future<Either<Failure, bool>> deleteService(String serviceId);
  Future<Either<Failure, ServiceEntity>> editService(ServiceEntity service);
  Future<Either<Failure, List<ServiceEntity>>> getServices();
}
