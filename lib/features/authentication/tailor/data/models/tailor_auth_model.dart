import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';

class TailorModel extends Tailor {
  TailorModel({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String user_type,
    required double latitude,
    required double longitude,
    required String services_summary,
    required String stripe_account_id,
    required bool stripe_onboarding_completed,
    required String fcm_token,
    required String profile_picture,
  }) : super(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          address: address,
          user_type: user_type,
          latitude: latitude,
          longitude: longitude,
          services_summary: services_summary,
          stripe_account_id: stripe_account_id,
          stripe_onboarding_completed: stripe_onboarding_completed,
          fcm_token: fcm_token,
          profile_picture: profile_picture,
        );

  factory TailorModel.fromJson(Map<String, dynamic> json) {
    return TailorModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phoneNumber: json['phone'] ?? '',
      address: json['address'] ?? '',
      user_type: json['user_type'] ?? '',
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0,
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0,
      services_summary: json['services_summary'] ?? '',
      stripe_account_id: json['stripe_account_id'] ?? '',
      stripe_onboarding_completed:
          json['stripe_onboarding_completed'] == 1 ? true : false,
      fcm_token: json['fcm_token'] ?? '',
      profile_picture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'address': address,
      'user_type': user_type,
      'latitude': latitude,
      'longitude': longitude,
      'services_summary': services_summary,
    };
  }
}
