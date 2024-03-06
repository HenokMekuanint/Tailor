import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int tailorId;
  final int serviceId;
  final int userId;
  final int id;
  final List<DateTime> pickUpDate;
  final List<DateTime> dropOffDate;
  final String name;
  final String email;
  final String serviceName;
  final String serviceDescription;
  final double price;
  final String status;
  final String address;
  final String paymentStatus;

  const OrderEntity({
    required this.tailorId,
    required this.serviceId,
    required this.dropOffDate,
    required this.pickUpDate,
    required this.address,
    required this.email,
    required this.id,
    required this.name,
    required this.price,
    required this.serviceDescription,
    required this.serviceName,
    required this.status,
    required this.userId,
    required this.paymentStatus,
  });

  @override
  List<Object?> get props => [tailorId, serviceId];
}
