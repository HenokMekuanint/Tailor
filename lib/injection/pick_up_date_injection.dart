import 'package:get_it/get_it.dart';
import 'package:mobile/features/pick_up_date/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:mobile/features/pick_up_date/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:mobile/features/pick_up_date/data/repositories/repository_impl.dart';
import 'package:mobile/features/pick_up_date/domain/repositories/pick_up_date_repository.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/create_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/delete_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/get_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/get_pick_up_dates.dart';
import 'package:mobile/features/pick_up_date/domain/use_cases/update_pick_up_date.dart';
import 'package:mobile/features/pick_up_date/presentation/bloc/pick_up_date_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initPickUpDateDepInj() async {
  //! Features - PickUpDate
  // Bloc
  sl.registerFactory(
    () => PickUpDateBloc(
      getPickUpDateUseCase: sl(),
      getPickUpDatesUseCase: sl(),
      updatePickUpDateUseCase: sl(),
      createPickUpDateUseCase: sl(),
      deletePickUpDateUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetPickUpDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPickUpDatesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePickUpDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreatePickUpDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePickUpDateUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PickUpDateRepository>(
    () => PickUpDateRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<PickUpDateRemoteDataSource>(
    () => PickUpDateRemoteDataSourceImpl(client: sl()),
  );
}
