import 'package:equatable/equatable.dart';

class CreateOrderEntity extends Equatable {
  final int tailorId;
  final int serviceId;
  final int? userId;
  final int? id;
  final List<DateTime> pickUpDate;
  final List<DateTime> dropOffDate;

  const CreateOrderEntity({
    required this.tailorId,
    required this.serviceId,
    required this.dropOffDate,
    required this.pickUpDate,
    this.id, 
    this.userId
  });

  @override
  List<Object?> get props => [tailorId, serviceId];
}
