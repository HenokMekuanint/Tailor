import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/domain/entities/create_pick_up_date_response_entity.dart';

class CreatePickUpDateModel extends CreatePickUpDateEntity {
  CreatePickUpDateModel({required super.pickUpDateTime});

  Map<String, dynamic> toJson() {
    return {
      'pickUpDateTime': pickUpDateTime,
    };
  }
}

class CreatePickUpDateResponseModel extends CreatePickUpDateResponseEntity {
  const CreatePickUpDateResponseModel({required super.message});

  factory CreatePickUpDateResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePickUpDateResponseModel(
      message: json['message'] ?? "Successfully created drop off date ",
    );
  }
}

extension CreatePickUpDateMapper on CreatePickUpDateEntity {
  CreatePickUpDateModel toCreatePickUpDateModel() {
    return CreatePickUpDateModel(
      pickUpDateTime: pickUpDateTime,
    );
  }
}
