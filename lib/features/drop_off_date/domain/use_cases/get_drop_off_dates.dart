import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';

class GetDropOffDatesUseCase
    extends UseCase<List<DropOffDateEntity>, NoParams> {
  final DropOffDateRepository repository;

  GetDropOffDatesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<DropOffDateEntity>>> call(NoParams params) async {
    return await repository.getDropOffDates();
  }
}
