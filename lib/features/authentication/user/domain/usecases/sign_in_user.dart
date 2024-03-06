import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class SignInUser {
  final UserAuthRepository repository;
  SignInUser({required this.repository});

  Future<Either<Failure, User>> call(UserLogin user) async {
    debugPrint('user login use_case user: $user');
    return await repository.signInUser(user);
  }
}
