import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/exceptions.dart';

import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/drop_off_date/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:mobile/features/drop_off_date/data/models/create.dart';
import 'package:mobile/features/drop_off_date/data/models/drop_off_date_model.dart';

import 'package:mobile/features/drop_off_date/domain/entities/create_drop_off_date_entity.dart';

import 'package:mobile/features/drop_off_date/domain/entities/delete_drop_of_date_response.dart';

import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';

import '../../domain/repositories/drop_off_date_repository.dart';

class DropOffDateRepositoryImpl extends DropOffDateRepository {
  final DropOffDateRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DropOffDateRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, DropOffDateEntity>> createDropOffDate(
      CreateDropOffDateEntity createDropOffDateEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final dropOffDate = await remoteDataSource.createDropOffDate(
            createDropOffDateEntity.toCreateDropOffDateModel());

        return Right(dropOffDate);
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
  Future<Either<Failure, DeleteDropOffDateResponse>> deleteDropOffDate(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final dropOffDate = await remoteDataSource.deleteDropOffDate(id);

        return Right(dropOffDate);
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
  Future<Either<Failure, DropOffDateEntity>> getDropOffDateById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final dropOffDate = await remoteDataSource.getDropOffDateById(id);

        return Right(dropOffDate);
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
  Future<Either<Failure, List<DropOffDateEntity>>> getDropOffDates() async {
    if (await networkInfo.isConnected) {
      try {
        final dropOffDates = await remoteDataSource.getDropOffDates();
        return Right(dropOffDates);
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
  Future<Either<Failure, DropOffDateEntity>> updateDropOffDate(
      DropOffDateEntity dropOffDateEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final dropOffDate = await remoteDataSource
            .updateDropOffDate(dropOffDateEntity.toDropOffDateModel());
        return Right(dropOffDate);
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
