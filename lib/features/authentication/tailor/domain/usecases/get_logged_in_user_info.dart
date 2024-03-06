import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class GetLoggedInTailorInfoLocal {
  final TailorAuthRepository repository;
  GetLoggedInTailorInfoLocal({required this.repository});

  Future<Either<Failure, Tailor>> call() async {
    debugPrint('Tailor info local use_case Tailor:');
    return await repository.getTailorInfoFromLocal();
  }
}
