import 'package:mobile/features/authentication/user/domain/entities/user_update_profile_entity.dart';

class UserUpdateProfileModel extends UserUpdateProfileEntity {
  const UserUpdateProfileModel({
    String? name,
    String? address,
  }) : super(
          name: name,
          address: address,
        );

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'user_type': 'user'};
  }
}

extension UserUpdateProfileModelWrapper on UserUpdateProfileEntity {
  UserUpdateProfileModel toUpdateUserProfileModel() {
    return UserUpdateProfileModel(
      name: name,
      address: address,
    );
  }
}
