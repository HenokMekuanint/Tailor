import 'package:equatable/equatable.dart';

class NearestTailorsEntity extends Equatable {
  final bool status;
  final String message;
  final List<NearestTailorDataEntity> nearestTailors;

  const NearestTailorsEntity(
      {required this.status,
      required this.message,
      required this.nearestTailors});

  @override
  List<Object?> get props => [status, message, nearestTailors];
}

class NearestTailorDataEntity {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String servicesSummary;
  final double latitude;
  final double longitude;
  final double distance;
  final String address;

  NearestTailorDataEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.servicesSummary,
      required this.latitude,
      required this.longitude,
      required this.distance,
      required this.address});
}
