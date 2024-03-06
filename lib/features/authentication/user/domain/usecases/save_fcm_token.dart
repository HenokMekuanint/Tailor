import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';

import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class UserSaveFcmTokenUseCase extends UseCase<User, String> {
  final UserAuthRepository repository;

  UserSaveFcmTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(String params) async {
    return await repository.saveFcmToken(params);
  }
}
