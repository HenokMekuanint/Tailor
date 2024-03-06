import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';

import 'package:mobile/features/authentication/tailor/domain/entities/tailor_update_profile_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class UpdateProfileTailor {
  final TailorAuthRepository repository;
  UpdateProfileTailor({required this.repository});

  Future<Either<Failure, Tailor>> call(
      TailorUpdateProfileEntity tailorUpdateProfileEntity) async {
    debugPrint(
        'tailor update profile use_case tailor: $tailorUpdateProfileEntity');
    return await repository.updateProfile(tailorUpdateProfileEntity);
  }
}
