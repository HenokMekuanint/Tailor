// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class UserLogin extends Equatable {
  final String email;
  final String password;
  final String user_type;

  UserLogin({
    required this.email,
    required this.password,
    required this.user_type,
  }) : super();

  @override
  List<Object> get props => [email, user_type];
}
