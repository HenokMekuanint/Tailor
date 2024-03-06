// ignore_for_file: non_constant_identifier_names

import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';

class UserLoginModel extends UserLogin {
  UserLoginModel({
    required String email,
    required String password,
    required String user_type,
  }) : super(
          email: email,
          password: password,
          user_type: user_type,
        );

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      email: json['email'],
      password: json['password'],
      user_type: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'user_type': user_type,
    };
  }
}
