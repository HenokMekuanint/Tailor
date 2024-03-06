// ignore_for_file: non_constant_identifier_names

import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';

class UserModel extends User {
  UserModel({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String user_type,
    required String fcm_token,
    required String profile_picture,
  }) : super(
            name: name,
            email: email,
            password: password,
            phone: phone,
            address: address,
            user_type: user_type,
            fcm_token: fcm_token,
            profile_picture: profile_picture);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      user_type: json['user_type'] ?? '',
      fcm_token: json['fcm_token'] ?? '',
      profile_picture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'user_type': user_type,
    };
  }
}
