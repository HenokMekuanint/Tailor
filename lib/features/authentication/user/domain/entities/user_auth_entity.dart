// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String user_type;
  final String fcm_token;
  final String? profile_picture;
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.user_type,
    required this.fcm_token,
    this.profile_picture,
  }) : super();

  @override
  List<Object> get props => [name, email];
}
