import 'package:mobile/features/drop_off_date/domain/entities/delete_drop_of_date_response.dart';

class DeleteDropOffDateResponseModel extends DeleteDropOffDateResponse {
  const DeleteDropOffDateResponseModel({required super.message});

  factory DeleteDropOffDateResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteDropOffDateResponseModel(
      message: json['message'] ?? "Successfully deleted drop off date",
    );
  }
}
