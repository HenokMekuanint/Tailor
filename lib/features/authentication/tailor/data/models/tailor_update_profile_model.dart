import 'package:mobile/features/authentication/tailor/domain/entities/tailor_update_profile_entity.dart';

class TailorUpdateProfileModel extends TailorUpdateProfileEntity {
  const TailorUpdateProfileModel({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? servicesSummary,
  }) : super(
          name: name,
          address: address,
          latitude: latitude,
          longitude: longitude,
          servicesSummary: servicesSummary,
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'services_summary': servicesSummary,
      'user_type': 'tailor'
    };
  }
}

extension TailorUpdateProfileModelWrapper on TailorUpdateProfileEntity {
  TailorUpdateProfileModel toTailorUpdateProfileModel() {
    return TailorUpdateProfileModel(
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      servicesSummary: servicesSummary,
    );
  }
}
