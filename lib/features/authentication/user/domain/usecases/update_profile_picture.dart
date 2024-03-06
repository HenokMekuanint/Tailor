import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';

class UserUpdateProfilePicUseCase extends UseCase<User, XFile> {
  final UserAuthRepository userAuthRepository;

  UserUpdateProfilePicUseCase({required this.userAuthRepository});
  @override
  Future<Either<Failure, User>> call(XFile imageFile) async {
    return await userAuthRepository.updateProfilePicture(imageFile);
  }
}
