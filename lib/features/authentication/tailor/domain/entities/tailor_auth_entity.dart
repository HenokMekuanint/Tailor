// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class Tailor extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String user_type;
  final double latitude;
  final double longitude;
  final String services_summary;
  final String? stripe_account_id;
  final String? profile_picture;
  final bool? stripe_onboarding_completed;
  final String? fcm_token;
  Tailor({
    required this.name,
    required this.email,
    required this.password,
    required this.user_type,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.services_summary,
    this.stripe_account_id,
    this.stripe_onboarding_completed,
    this.fcm_token,
    this.profile_picture,
  }) : super();

  @override
  List<Object> get props => [
        name,
        email,
        password,
        phoneNumber,
        address,
        user_type,
        latitude,
        longitude,
        services_summary,
        stripe_account_id ?? "",
        stripe_onboarding_completed ?? false,
        fcm_token ?? "",
        profile_picture ?? ""
      ];
}
