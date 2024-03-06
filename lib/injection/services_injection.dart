import 'package:get_it/get_it.dart';
import 'package:mobile/features/tailor_service/data/datasources/service_remote_data_source.dart';
import 'package:mobile/features/tailor_service/data/repositories/service_repository_impl.dart';
import 'package:mobile/features/tailor_service/domain/repository/service_repository.dart';
import 'package:mobile/features/tailor_service/domain/usecases/create_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/delete_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/edit_service.dart';
import 'package:mobile/features/tailor_service/domain/usecases/get_services.dart';
import 'package:mobile/features/tailor_service/presentation/bloc/service_bloc.dart';

final sl = GetIt.instance;
Future<void> serviceInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => ServiceBloc(
        createService: sl(),
        deleteService: sl(),
        editService: sl(),
        getServices: sl()),
  );

  // usecases
  sl.registerLazySingleton(
    () => CreateService(repository: sl()),
  );

  sl.registerLazySingleton(
    () => EditService(repository: sl()),
  );

  sl.registerLazySingleton(
    () => DeleteService(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetServices(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<ServiceRepositoy>(
    () => ServiceRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSourceImpl(client: sl()),
  );
}
