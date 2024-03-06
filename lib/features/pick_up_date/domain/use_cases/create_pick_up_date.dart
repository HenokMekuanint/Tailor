import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class CreatePickUpDateUseCase
    extends UseCase<PickUpDateEntity, CreatePickUpDateParams> {
  final PickUpDateRepository repository;

  CreatePickUpDateUseCase({required this.repository});

  @override
  Future<Either<Failure, PickUpDateEntity>> call(
      CreatePickUpDateParams params) async {
    return await repository.createPickUpDate(params.pickUpDate);
  }
}

class CreatePickUpDateParams {
  final CreatePickUpDateEntity pickUpDate;

  CreatePickUpDateParams({required this.pickUpDate});
}
