import 'package:get_it/get_it.dart';
import 'package:mobile/features/drop_off_date/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:mobile/features/drop_off_date/data/data_sources/remote_data_source/remote_data_source_impl.dart';
import 'package:mobile/features/drop_off_date/data/repositories/repository_impl.dart';
import 'package:mobile/features/drop_off_date/domain/repositories/drop_off_date_repository.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/create_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/delete_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/get_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/get_drop_off_dates.dart';
import 'package:mobile/features/drop_off_date/domain/use_cases/update_drop_off_date.dart';
import 'package:mobile/features/drop_off_date/presentation/bloc/drop_off_date_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initDropOffDateDepInj() async {
  //! Features - DropOffDate
  // Bloc
  sl.registerFactory(
    () => DropOffDateBloc(
      getDropOffDateUseCase: sl(),
      getDropOffDatesUseCase: sl(),
      updateDropOffDateUseCase: sl(),
      createDropOffDateUseCase: sl(),
      deleteDropOffDateUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetDropOffDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDropOffDatesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateDropOffDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateDropOffDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteDropOffDateUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<DropOffDateRepository>(() =>
      DropOffDateRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<DropOffDateRemoteDataSource>(
    () => DropOffDateRemoteDataSourceImpl(client: sl()),
  );
}
