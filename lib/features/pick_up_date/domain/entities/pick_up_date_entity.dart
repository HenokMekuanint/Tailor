import 'package:equatable/equatable.dart';

class PickUpDateEntity extends Equatable {
  final String pickUpDateTime;
  final int id;
  final int tailorId;

  const PickUpDateEntity(
      {required this.pickUpDateTime, required this.id, required this.tailorId});

  @override
  List<Object?> get props => [pickUpDateTime, id, tailorId];
}
