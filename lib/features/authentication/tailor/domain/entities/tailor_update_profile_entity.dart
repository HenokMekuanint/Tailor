import 'package:equatable/equatable.dart';

class TailorUpdateProfileEntity extends Equatable {
  final String? name;

  final String? address;
  final double? latitude;
  final double? longitude;
  final String? servicesSummary;

  const TailorUpdateProfileEntity({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.servicesSummary,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        latitude,
        longitude,
        servicesSummary,
      ];
}
