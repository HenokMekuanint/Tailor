import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';

class PickUpDateModel extends PickUpDateEntity {
  const PickUpDateModel(
      {required super.pickUpDateTime,
      required super.id,
      required super.tailorId});

  factory PickUpDateModel.fromJson(Map<String, dynamic> json) {
    return PickUpDateModel(
      pickUpDateTime: json['pickUpDateTime'],
      id: json['id'],
      tailorId: json['tailor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickUpDateTime': pickUpDateTime,
      'id': id,
      'tailor_id': tailorId,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'pickUpDateTime': pickUpDateTime,
    };
  }
}

extension PickUpDateMapper on PickUpDateEntity {
  PickUpDateModel toPickUpDateModel() {
    return PickUpDateModel(
      pickUpDateTime: pickUpDateTime,
      id: id,
      tailorId: tailorId,
    );
  }
}
