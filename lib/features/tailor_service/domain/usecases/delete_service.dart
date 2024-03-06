import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';

class DeleteService {
  final ServiceRepositoy repository;
  DeleteService({required this.repository});

  Future<Either<Failure, bool>> call(String serviceId) async {
    return await repository.deleteService(serviceId);
  }
}
