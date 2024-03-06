// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class SignOutTailor {
  final TailorAuthRepository repository;
  SignOutTailor({required this.repository});

  Future<Either<Failure, String>> call(String user_type) async {
    debugPrint('tailor logout use_case type: $user_type');
    return await repository.signOutTailor(user_type);
  }
}
