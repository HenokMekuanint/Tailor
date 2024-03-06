import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class GetPickUpDateUseCase
    extends UseCase<PickUpDateEntity, GetPickUpDateParams> {
  final PickUpDateRepository repository;

  GetPickUpDateUseCase({required this.repository});

  @override
  Future<Either<Failure, PickUpDateEntity>> call(
      GetPickUpDateParams params) async {
    return await repository.getPickUpDateById(params.id);
  }
}

class GetPickUpDateParams {
  final int id;

  GetPickUpDateParams({required this.id});
}
