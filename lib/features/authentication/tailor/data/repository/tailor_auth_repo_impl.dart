// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/authentication/tailor/data/datasources/tailor_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_update_profile_model.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_login_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_update_profile_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';

class TailorAuthRepositoryImpl implements TailorAuthRepository {
  final TailorAuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TailorAuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Tailor>> signUpTailor(Tailor tailor) async {
    if (await networkInfo.isConnected) {
      try {
        final registeredTailor = await remoteDataSource.signUpTailor(tailor);
        final String tailorModelToString =
            json.encode(registeredTailor.toJson());
        prefManager.setString(
            SharedPrefKeys.loggedInTailorInfo, tailorModelToString);
        return Right(registeredTailor);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, Tailor>> signInTailor(TailorLogin tailor) async {
    if (await networkInfo.isConnected) {
      try {
        final loggedTailor = await remoteDataSource.signInTailor(tailor);
        final String tailorModelToString = json.encode(loggedTailor.toJson());
        prefManager.setString(
            SharedPrefKeys.loggedInTailorInfo, tailorModelToString);
        return Right(loggedTailor);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, String>> signOutTailor(String user_type) async {
    if (await networkInfo.isConnected) {
      try {
        final message = await remoteDataSource.signOutTailor(user_type);
        prefManager.clear();
        return Right(message);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, Tailor>> updateProfile(
      TailorUpdateProfileEntity tailorUpdateProfileEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedTailor = await remoteDataSource.updateProfile(
            tailorUpdateProfileEntity.toTailorUpdateProfileModel());
        final String tailorModelToString = json.encode(updatedTailor.toJson());
        prefManager.setString(
            SharedPrefKeys.loggedInTailorInfo, tailorModelToString);
        return Right(updatedTailor);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, Tailor>> getTailorInfoFromLocal() async {
    try {
      final String? tailorModelToString =
          prefManager.getString(SharedPrefKeys.loggedInTailorInfo);

      if (tailorModelToString != null && tailorModelToString.isNotEmpty) {
        final TailorModel tailor =
            TailorModel.fromJson(json.decode(tailorModelToString));
        return Right<Failure, Tailor>(tailor);
      } else {
        // If tailorModelToString is null or empty, the tailor information is not available locally.
        return Left<Failure, Tailor>(
            NotFoundFailure(message: 'Tailor information not found locally'));
      }
    } catch (e) {
      return Left<Failure, Tailor>(UnknownFailure(
          message:
              'Error ocurred while trying to get the tailor information locally'));
    }
  }

  @override
  Future<Either<Failure, Tailor>> saveFcmToken(String fcmToken) async {
    if (await networkInfo.isConnected) {
      try {
        final TailorModel tailor =
            await remoteDataSource.saveFcmToken(fcmToken);
        final String tailorModelToString = json.encode(tailor.toJson());
        prefManager.setString(
            SharedPrefKeys.loggedInTailorInfo, tailorModelToString);
        return Right(tailor);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }

  @override
  Future<Either<Failure, Tailor>> updateProfilePicture(XFile profile) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedTailor =
            await remoteDataSource.updateProfilePicture(profile);
        final String tailorModelToString = json.encode(updatedTailor.toJson());
        prefManager.setString(
            SharedPrefKeys.loggedInTailorInfo, tailorModelToString);
        return Right(updatedTailor);
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
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
