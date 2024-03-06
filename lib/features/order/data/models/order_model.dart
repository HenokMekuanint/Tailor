// ignore_for_file: must_be_immutable

import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required int tailorId,
    required int serviceId,
    required int userId,
    required int id,
    required List<DateTime> pickUpDate,
    required List<DateTime> dropOffDate,
    required String name,
    required String email,
    required String serviceName,
    required String serviceDescription,
    required double price,
    required String status,
    required String address,
    required String paymentStatus,
  }) : super(
          address: address,
          dropOffDate: dropOffDate,
          email: email,
          id: id,
          name: name,
          pickUpDate: pickUpDate,
          price: price,
          serviceDescription: serviceDescription,
          serviceId: serviceId,
          serviceName: serviceName,
          status: status,
          tailorId: tailorId,
          userId: userId,
          paymentStatus: paymentStatus,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final String userType =
        prefManager.getString(SharedPrefKeys.userType)! == 'user'
            ? 'tailor'
            : 'user';
    // Pickup date
    List<String> pickUpDates = json['pickUpDateTime'].split(',');
    List<DateTime> pickUpDateTimes = parseDateStrings(pickUpDates);
    // Pickup date
    List<String> dropOffDates = json['dropOffDateTime'].split(',');
    List<DateTime> dropOffDateTimes = parseDateStrings(dropOffDates);

    return OrderModel(
      id: json['id'],
      pickUpDate: pickUpDateTimes,
      dropOffDate: dropOffDateTimes,
      serviceId: json['service_id'],
      tailorId: json['tailor_id'],
      userId: json['user_id'],
      status: json['status'] ?? 'pending',
      email: json[userType]['email'] ?? 'email is null',
      name: json[userType]['name'] ?? 'initial name is null',
      address: json['address'] ?? 'address is null',
      price: (json['service']['price'] as num?)?.toDouble() ?? 0.0,
      serviceDescription:
          json['service']['description'] ?? 'descrition is null',
      serviceName: json['service']['name'] ?? 'service name is null',
      paymentStatus: json['payment_status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tailor_id': tailorId,
      'service_id': serviceId,
      'pickUpDateTime': pickUpDate,
      'dropOffDateTime': dropOffDate,
    };
  }

  static List<DateTime> parseDateStrings(List<String> dateStrings) {
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
  }
}
