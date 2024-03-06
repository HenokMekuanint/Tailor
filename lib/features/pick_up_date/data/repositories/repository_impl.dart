import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/exceptions.dart';

import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';

import 'package:mobile/features/pick_up_date/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:mobile/features/pick_up_date/data/models/create.dart';
import 'package:mobile/features/pick_up_date/data/models/pick_up_date_model.dart';
import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/delete_pick_up_date_response.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';

class PickUpDateRepositoryImpl extends PickUpDateRepository {
  final PickUpDateRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PickUpDateRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, PickUpDateEntity>> createPickUpDate(
      CreatePickUpDateEntity createPickUpDateEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final pickUpDate = await remoteDataSource
            .createPickUpDate(createPickUpDateEntity.toCreatePickUpDateModel());

        return Right(pickUpDate);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, DeletePickUpDateResponse>> deletePickUpDate(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.deletePickUpDate(id);

        return Right(response);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, PickUpDateEntity>> getPickUpDateById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final pickUpDate = await remoteDataSource.getPickUpDateById(id);

        return Right(pickUpDate);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, List<PickUpDateEntity>>> getPickUpDates() async {
    if (await networkInfo.isConnected) {
      try {
        final pickUpDates = await remoteDataSource.getPickUpDates();
        return Right(pickUpDates);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, PickUpDateEntity>> updatePickUpDate(
      PickUpDateEntity pickUpDateEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final pickUpDate = await remoteDataSource
            .updatePickUpDate(pickUpDateEntity.toPickUpDateModel());
        return Right(pickUpDate);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
