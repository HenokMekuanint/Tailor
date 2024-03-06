import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class SignUpTailor {
  final TailorAuthRepository repository;
  SignUpTailor({required this.repository});

  Future<Either<Failure, Tailor>> call(Tailor user) async {
    debugPrint('tailor sign_up use_case tailor: $user');
    return await repository.signUpTailor(user);
  }
}
