// ignore_for_file: must_be_immutable

import 'package:mobile/features/order/domain/entities/create_order_entity.dart';

class CreateOrderModel extends CreateOrderEntity {
  const CreateOrderModel(
      {required int tailorId,
      required int serviceId,
      required List<DateTime> pickUpDate,
      required List<DateTime> dropOffDate,
      int? id,
      int? userId})
      : super(
          dropOffDate: dropOffDate,
          pickUpDate: pickUpDate,
          serviceId: serviceId,
          tailorId: tailorId,
          id: id,
          userId: userId,
        );

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    List<String> pickUpDates = json['pickUpDateTime'].split(',');
    List<DateTime> pickUpDateTimes = parseDateStrings(pickUpDates);
    // Pickup date
    List<String> dropOffDates = json['dropOffDateTime'].split(',');
    List<DateTime> dropOffDateTimes = parseDateStrings(dropOffDates);

    return CreateOrderModel(
      tailorId: json['tailor_id'],
      serviceId: json['service_id'],
      pickUpDate: pickUpDateTimes,
      dropOffDate: dropOffDateTimes,
      id: json['id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tailor_id': tailorId,
      'service_id': serviceId,
      'pickUpDateTime': '${pickUpDate[0]},${pickUpDate[1]}',
      'dropOffDateTime': '${dropOffDate[0]},${dropOffDate[1]}',
    };
  }

  static List<DateTime> parseDateStrings(List<String> dateStrings) {
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
  }
}
