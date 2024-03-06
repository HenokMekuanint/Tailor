import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class SignUpUser {
  final UserAuthRepository repository;
  SignUpUser({required this.repository});

  Future<Either<Failure, User>> call(User user) async {
    debugPrint('user sign_up use_case user: $user');
    return await repository.signUpUser(user);
  }
}
