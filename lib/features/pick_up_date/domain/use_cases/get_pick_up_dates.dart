import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class GetPickUpDatesUseCase extends UseCase<List<PickUpDateEntity>, NoParams> {
  final PickUpDateRepository repository;

  GetPickUpDatesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PickUpDateEntity>>> call(NoParams params) async {
    return await repository.getPickUpDates();
  }
}
