import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';

class TailorUpdateProfilePictureUseCase extends UseCase<Tailor, XFile> {
  final TailorAuthRepository repository;

  TailorUpdateProfilePictureUseCase({required this.repository});

  @override
  Future<Either<Failure, Tailor>> call(XFile pickedPic) async {
    return await repository.updateProfilePicture(pickedPic);
  }
}
