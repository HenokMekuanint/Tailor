import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';

import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/delete_pick_up_date_response.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';

abstract class PickUpDateRepository {
  Future<Either<Failure, PickUpDateEntity>> createPickUpDate(
      CreatePickUpDateEntity createPickUpDateEntity);

  Future<Either<Failure, List<PickUpDateEntity>>> getPickUpDates();

  Future<Either<Failure, PickUpDateEntity>> updatePickUpDate(
      PickUpDateEntity pickUpDateEntity);

  Future<Either<Failure, DeletePickUpDateResponse>> deletePickUpDate(int id);

  Future<Either<Failure, PickUpDateEntity>> getPickUpDateById(int id);
}
