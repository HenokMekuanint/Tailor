// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_login_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_update_profile_entity.dart';

abstract class TailorAuthRepository {
  Future<Either<Failure, Tailor>> signUpTailor(Tailor tailor);
  Future<Either<Failure, Tailor>> signInTailor(TailorLogin tailor);
  Future<Either<Failure, String>> signOutTailor(String user_type);

  Future<Either<Failure, Tailor>> updateProfile(
      TailorUpdateProfileEntity tailorUpdateProfileEntity);

  Future<Either<Failure, Tailor>> getTailorInfoFromLocal();

  Future<Either<Failure, Tailor>> saveFcmToken(String fcmToken);

  Future<Either<Failure, Tailor>> updateProfilePicture(XFile imageFile);
}
