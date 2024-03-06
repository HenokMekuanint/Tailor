import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';

class EditService {
  final ServiceRepositoy repository;
  EditService({required this.repository});

  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) async {
    return await repository.editService(service);
  }
}
