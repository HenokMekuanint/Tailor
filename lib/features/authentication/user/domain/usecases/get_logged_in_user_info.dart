import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class GetLoggedInUserInfoLocal {
  final UserAuthRepository repository;
  GetLoggedInUserInfoLocal({required this.repository});

  Future<Either<Failure, User>> call() async {
    debugPrint('user info local use_case user:');
    return await repository.getUserInfoFromLocal();
  }
}
