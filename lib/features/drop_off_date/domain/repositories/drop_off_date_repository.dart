import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/drop_off_date/domain/entities/create_drop_off_date_entity.dart';

import 'package:mobile/features/drop_off_date/domain/entities/delete_drop_of_date_response.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';

abstract class DropOffDateRepository {
  Future<Either<Failure, DropOffDateEntity>> createDropOffDate(
      CreateDropOffDateEntity createDropOffDateEntity);

  Future<Either<Failure, List<DropOffDateEntity>>> getDropOffDates();

  Future<Either<Failure, DropOffDateEntity>> updateDropOffDate(
      DropOffDateEntity dropOffDateEntity);

  Future<Either<Failure, DeleteDropOffDateResponse>> deleteDropOffDate(int id);

  Future<Either<Failure, DropOffDateEntity>> getDropOffDateById(int id);
}
