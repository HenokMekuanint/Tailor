import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';

import '../entities/create_drop_off_date_entity.dart';

class CreateDropOffDateUseCase
    extends UseCase<DropOffDateEntity, CreateDropOffDateParams> {
  final DropOffDateRepository repository;

  CreateDropOffDateUseCase({required this.repository});

  @override
  Future<Either<Failure, DropOffDateEntity>> call(
      CreateDropOffDateParams params) async {
    return await repository.createDropOffDate(params.dropOffDate);
  }
}

class CreateDropOffDateParams {
  final CreateDropOffDateEntity dropOffDate;

  CreateDropOffDateParams({required this.dropOffDate});
}
