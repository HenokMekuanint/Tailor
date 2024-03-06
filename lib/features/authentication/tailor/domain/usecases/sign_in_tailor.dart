import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_login_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class SignInTailor {
  final TailorAuthRepository repository;
  SignInTailor({required this.repository});

  Future<Either<Failure, Tailor>> call(TailorLogin user) async {
    debugPrint('tailor login use_case tailor: $user');
    return await repository.signInTailor(user);
  }
}
