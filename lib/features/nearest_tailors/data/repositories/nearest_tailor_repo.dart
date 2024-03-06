import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/nearest_tailors/data/data_sources/remote_data_source/nearest_tailors_remote_data_source.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailor_detail_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailors_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailors.dart';
import 'package:mobile/features/nearest_tailors/data/models/search_nearest_tailors_by_address_request_model.dart';

class NearestTailorsRepository {
  final NearestTailorsRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  NearestTailorsRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, NearestTailors>> getNearestTailors(
      GetNearestTailorsRequestModel getNearestTailorsRequestModel) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNearestTailors = await remoteDataSource
            .getNearestTailors(getNearestTailorsRequestModel);
        // localDataSource.cacheNearestTailors(remoteNearestTailors);
        return Right(remoteNearestTailors);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  Future<Either<Failure, NearestTailorDetail>> getNearestTailorDetails(
      GetNearestTailorRequestModel getNearestTailorRequestModel) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNearestTailorDetail = await remoteDataSource
            .getNearestTailorDetail(getNearestTailorRequestModel);
        // localDataSource.cacheNearestTailors(remoteNearestTailors);
        return Right(remoteNearestTailorDetail);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  Future<Either<Failure, NearestTailors>> searchNearestTailorsByAddress(
      SearchNearestTailorsByAddressRequestModel searchModel) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNearestTailors = await remoteDataSource
            .searchNearestTailorsByAddress(searchModel);
        // localDataSource.cacheNearestTailors(remoteNearestTailors);
        return Right(remoteNearestTailors);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
