import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class UpdatePickUpDateUseCase
    extends UseCase<PickUpDateEntity, UpdatePickUpDateParams> {
  PickUpDateRepository repository;

  UpdatePickUpDateUseCase({required this.repository});

  @override
  Future<Either<Failure, PickUpDateEntity>> call(
      UpdatePickUpDateParams params) async {
    return await repository.updatePickUpDate(params.pickUpDate);
  }
}

class UpdatePickUpDateParams {
  final PickUpDateEntity pickUpDate;

  UpdatePickUpDateParams({required this.pickUpDate});
}
