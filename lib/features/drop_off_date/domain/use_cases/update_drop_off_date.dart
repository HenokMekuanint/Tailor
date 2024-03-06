import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';

class UpdateDropOffDateUseCase
    extends UseCase<DropOffDateEntity, UpdateDropOffDateParams> {
  DropOffDateRepository repository;

  UpdateDropOffDateUseCase({required this.repository});

  @override
  Future<Either<Failure, DropOffDateEntity>> call(
      UpdateDropOffDateParams params) async {
    return await repository.updateDropOffDate(params.dropOffDate);
  }
}

class UpdateDropOffDateParams {
  final DropOffDateEntity dropOffDate;

  UpdateDropOffDateParams({required this.dropOffDate});
}
