import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, User>> signUpUser(User user);
  Future<Either<Failure, User>> signInUser(UserLogin user);
  Future<Either<Failure, String>> signOutUser(String user_type);

  Future<Either<Failure, User>> updateProfile(
      UserUpdateProfileEntity userUpdateProfileEntity);

  Future<Either<Failure, User>> getUserInfoFromLocal();

  Future<Either<Failure, User>> saveFcmToken(String fcmToken);

  Future<Either<Failure, User>> updateProfilePicture(XFile imageFile);
}
