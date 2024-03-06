import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';

class GetServices {
  final ServiceRepositoy repository;
  GetServices({required this.repository});

  Future<Either<Failure, List<ServiceEntity>>> call() async {
    return await repository.getServices();
  }
}
