import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class UpdateProfileUser {
  final UserAuthRepository repository;
  UpdateProfileUser({required this.repository});

  Future<Either<Failure, User>> call(
      UserUpdateProfileEntity userUpdateProfileEntity) async {
    debugPrint('User update profile use_case User: $userUpdateProfileEntity');
    return await repository.updateProfile(userUpdateProfileEntity);
  }
}
