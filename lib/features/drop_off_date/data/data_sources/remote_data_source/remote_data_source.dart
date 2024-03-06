import 'package:mobile/features/drop_off_date/data/models/create.dart';
import 'package:mobile/features/drop_off_date/data/models/delete.dart';
import 'package:mobile/features/drop_off_date/data/models/drop_off_date_model.dart';



abstract class DropOffDateRemoteDataSource {
  Future<DropOffDateModel> createDropOffDate(
      CreateDropOffDateModel createDropOffDateModel);
  Future<List<DropOffDateModel>> getDropOffDates();
  Future<DropOffDateModel> updateDropOffDate(DropOffDateModel dropOffDateModel);
  Future<DeleteDropOffDateResponseModel> deleteDropOffDate(int id);
  Future<DropOffDateModel> getDropOffDateById(int id);
}
