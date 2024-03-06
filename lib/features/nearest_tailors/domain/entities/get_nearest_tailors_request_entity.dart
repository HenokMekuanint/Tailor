import 'package:equatable/equatable.dart';

class GetNearestTailorsRequestEntity extends Equatable {
  final double latitude;
  final double longitude;

  const GetNearestTailorsRequestEntity(
      {required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
