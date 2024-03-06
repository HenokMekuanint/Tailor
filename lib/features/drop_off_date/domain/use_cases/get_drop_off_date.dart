import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';

class GetDropOffDateUseCase
    extends UseCase<DropOffDateEntity, GetDropOffDateParams> {
  final DropOffDateRepository repository;

  GetDropOffDateUseCase({required this.repository});

  @override
  Future<Either<Failure, DropOffDateEntity>> call(
      GetDropOffDateParams params) async {
    return await repository.getDropOffDateById(params.id);
  }
}

class GetDropOffDateParams {
  final int id;

  GetDropOffDateParams({required this.id});
}
