import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';

class DropOffDateModel extends DropOffDateEntity {
  const DropOffDateModel(
      {required super.dropOffDateTime,
      required super.id,
      required super.tailorId});

  factory DropOffDateModel.fromJson(Map<String, dynamic> json) {
    return DropOffDateModel(
      dropOffDateTime: json['dropOffDateTime'],
      id: json['id'],
      tailorId: json['tailor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dropOffDateTime': dropOffDateTime,
      'id': id,
      'tailor_id': tailorId,
    };
  }
}

extension DropOffDateMapper on DropOffDateEntity {
  DropOffDateModel toDropOffDateModel() {
    return DropOffDateModel(
      dropOffDateTime: dropOffDateTime,
      id: id,
      tailorId: tailorId,
    );
  }
}
