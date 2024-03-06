import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/tailor_service/data/datasources/service_remote_data_source.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepositoy {
  final ServiceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  // Create Service
  @override
  Future<Either<Failure, ServiceEntity>> createService(
      ServiceEntity service) async {
    if (await networkInfo.isConnected) {
      try {
        final createdService = await remoteDataSource.createService(service);
        return Right(createdService);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // Edit Service
  @override
  Future<Either<Failure, ServiceEntity>> editService(
      ServiceEntity service) async {
    if (await networkInfo.isConnected) {
      try {
        final editedService = await remoteDataSource.editService(service);
        debugPrint('tailor editService response body: $editedService');

        return Right(editedService);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // Delete Service
  @override
  Future<Either<Failure, bool>> deleteService(String serviceId) async {
    if (await networkInfo.isConnected) {
      try {
        final status = await remoteDataSource.deleteService(serviceId);
        return Right(status);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // Get Services
  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    if (await networkInfo.isConnected) {
      try {
        final services = await remoteDataSource.getServices();
        return Right(services);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }
}
