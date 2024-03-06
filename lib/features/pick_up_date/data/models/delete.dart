import 'package:mobile/features/pick_up_date/domain/entities/delete_pick_up_date_response.dart';

class DeletePickUpDateResponseModel extends DeletePickUpDateResponse {
  const DeletePickUpDateResponseModel({required super.message});

  factory DeletePickUpDateResponseModel.fromJson(Map<String, dynamic> json) {
    return DeletePickUpDateResponseModel(
      message: json['message'] ?? "Successfully deleted drop off date",
    );
  }
}
