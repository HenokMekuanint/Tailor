import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/drop_off_date/domain/entities/delete_drop_of_date_response.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';

class DeleteDropOffDateUseCase
    extends UseCase<DeleteDropOffDateResponse, DeleteDropOffDateParams> {
  DropOffDateRepository repository;

  DeleteDropOffDateUseCase({required this.repository});

  @override
  Future<Either<Failure, DeleteDropOffDateResponse>> call(
      DeleteDropOffDateParams params) async {
    return await repository.deleteDropOffDate(params.id);
  }
}

class DeleteDropOffDateParams {
  final int id;

  DeleteDropOffDateParams({required this.id});
}
