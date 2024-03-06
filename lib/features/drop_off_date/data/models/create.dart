import 'package:mobile/features/drop_off_date/domain/entities/create_drop_off_date_entity.dart';

import '../../domain/entities/create_drop_off_date_response_entity.dart';

class CreateDropOffDateModel extends CreateDropOffDateEntity {
  CreateDropOffDateModel({required super.dropOffDateTime});



  Map<String, dynamic> toJson() {
    return {
      'dropOffDateTime': dropOffDateTime,
    };
  }
}

class CreateDropOffDateResponseModel extends CreateDropOffDateResponseEntity {
  const CreateDropOffDateResponseModel({required super.message});

  factory CreateDropOffDateResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateDropOffDateResponseModel(
      message: json['message'] ?? "Successfully created drop off date ",
    );
  }
}


extension CreateDropOffDateMapper on CreateDropOffDateEntity{

  CreateDropOffDateModel toCreateDropOffDateModel(){
    return CreateDropOffDateModel(
      dropOffDateTime: dropOffDateTime,
    );
  }
}
