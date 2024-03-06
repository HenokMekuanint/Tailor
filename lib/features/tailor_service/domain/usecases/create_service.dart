import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';

class CreateService {
  final ServiceRepositoy repository;
  CreateService({required this.repository});

  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) async {
    return await repository.createService(service);
  }
}
