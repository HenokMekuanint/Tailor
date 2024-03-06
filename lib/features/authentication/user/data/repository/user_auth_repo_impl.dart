import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/authentication/user/data/datasources/user_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/data/models/user_update_profile_model.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserAuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserAuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, User>> signUpUser(User user) async {
    if (await networkInfo.isConnected) {
      try {
        final registeredUser = await remoteDataSource.signUpUser(user);
        return Right(registeredUser);
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
  Future<Either<Failure, User>> signInUser(UserLogin user) async {
    if (await networkInfo.isConnected) {
      try {
        final loggedUser = await remoteDataSource.signInUser(user);

        final String userToString = json.encode(loggedUser.toJson());
        prefManager.setString(SharedPrefKeys.loggedInUserInfo, userToString);
        return Right(loggedUser);
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
  Future<Either<Failure, String>> signOutUser(String user_type) async {
    if (await networkInfo.isConnected) {
      try {
        final message = await remoteDataSource.signOutUser(user_type);
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
  Future<Either<Failure, User>> updateProfile(
      UserUpdateProfileEntity userUpdateProfileEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedUser = await remoteDataSource
            .updateProfile(userUpdateProfileEntity.toUpdateUserProfileModel());
        final String userToString = json.encode(updatedUser.toJson());
        prefManager.setString(SharedPrefKeys.loggedInUserInfo, userToString);
        return Right(updatedUser);
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
  Future<Either<Failure, User>> getUserInfoFromLocal() async {
    try {
      String? userString =
          prefManager.getString(SharedPrefKeys.loggedInUserInfo);

      if (userString != null && userString.isNotEmpty) {
        UserModel user = UserModel.fromJson(json.decode(userString));
        return Right<Failure, User>(user);
      } else {
        // If userString is null or empty, the user information is not available locally.
        return Left<Failure, User>(
            NotFoundFailure(message: 'User information not found locally'));
      }
    } catch (e) {
      return Left<Failure, User>(UnknownFailure(
          message: "Error trying to get user information locally"));
    }
  }
  
  @override
  Future<Either<Failure, User>> saveFcmToken(String fcmToken) async{
   if(await networkInfo.isConnected){
      try{
        final UserModel user = await remoteDataSource.saveFcmToken(fcmToken);
        final String userToString = json.encode(user.toJson());
        prefManager.setString(SharedPrefKeys.loggedInUserInfo, userToString);
        return Right(user);
      }on InternalServerException catch(e){
        return Left(InternalServerFailure(message: e.message));
      }on UnAuthorizedException catch(e){
        return Left(UnAuthorizedFailure(message: e.message));
      }on InvalidInputException catch(e){
        return Left(InvalidInputFailure(message: e.message));
      }on NoInternetException catch(e){
        return Left(NoInternetFailure(message: e.message));
      }on NotFoundException catch(e){
        return Left(NotFoundFailure(message: e.message));
      }on ConnectionTimeoutException catch(e){
        return Left(ConnectionTimeoutFailure(message: e.message));
      }on UnknownException catch(e){
        return Left(UnknownFailure(message: e.message));
      }
    }else{
      return Left(NoInternetFailure(message: 'No Internet connection. Please check your Internet connection and try again'));

      
   }


    
  }

  @override
  Future<Either<Failure, User>> updateProfilePicture(XFile file)async {
    if(await networkInfo.isConnected){
      try{
        final UserModel user = await remoteDataSource.updateProfilePicture(file);
        final String userToString = json.encode(user.toJson());
        prefManager.setString(SharedPrefKeys.loggedInUserInfo, userToString);
        return Right(user);
      }on InternalServerException catch(e){
        return Left(InternalServerFailure(message: e.message));
      }on UnAuthorizedException catch(e){
        return Left(UnAuthorizedFailure(message: e.message));
      }on InvalidInputException catch(e){
        return Left(InvalidInputFailure(message: e.message));
      }on NoInternetException catch(e){
        return Left(NoInternetFailure(message: e.message));
      }on NotFoundException catch(e){
        return Left(NotFoundFailure(message: e.message));
      }on ConnectionTimeoutException catch(e){
        return Left(ConnectionTimeoutFailure(message: e.message));
      }on UnknownException catch(e){
        return Left(UnknownFailure(message: e.message));
      }
    }else{
      return Left(NoInternetFailure(message: 'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
