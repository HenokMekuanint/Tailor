import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class TailorSaveFcmTokenUseCase extends UseCase<Tailor, String> {
  final TailorAuthRepository repository;

  TailorSaveFcmTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, Tailor>> call(String params) async {
    return await repository.saveFcmToken(params);
  }
}
