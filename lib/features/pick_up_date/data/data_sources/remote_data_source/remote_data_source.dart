import 'package:mobile/features/pick_up_date/data/models/create.dart';
import 'package:mobile/features/pick_up_date/data/models/delete.dart';
import 'package:mobile/features/pick_up_date/data/models/pick_up_date_model.dart';

abstract class PickUpDateRemoteDataSource {
  Future<PickUpDateModel> createPickUpDate(
      CreatePickUpDateModel createPickUpDateModel);
  Future<List<PickUpDateModel>> getPickUpDates();
  Future<PickUpDateModel> updatePickUpDate(PickUpDateModel pickUpDateModel);
  Future<DeletePickUpDateResponseModel> deletePickUpDate(int id);
  Future<PickUpDateModel> getPickUpDateById(int id);
}
