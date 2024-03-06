import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/pick_up_date/domain/entities/delete_pick_up_date_response.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class DeletePickUpDateUseCase
    extends UseCase<DeletePickUpDateResponse, DeletePickUpDateParams> {
  PickUpDateRepository repository;

  DeletePickUpDateUseCase({required this.repository});

  @override
  Future<Either<Failure, DeletePickUpDateResponse>> call(
      DeletePickUpDateParams params) async {
    return await repository.deletePickUpDate(params.id);
  }
}

class DeletePickUpDateParams {
  final int id;

  DeletePickUpDateParams({required this.id});
}
