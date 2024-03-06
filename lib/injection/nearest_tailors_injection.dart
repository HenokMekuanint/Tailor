import 'package:get_it/get_it.dart';
import 'package:mobile/features/nearest_tailors/data/data_sources/remote_data_source/nearest_tailors_remote_data_source.dart';
import 'package:mobile/features/nearest_tailors/data/repositories/nearest_tailor_repo.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/user_nearest_tailors_bloc.dart';


final sl = GetIt.instance;

Future<void> initNearestTailorsDepInj() async {
  //! Bloc
  sl.registerFactory(() => UserNearestTailorsBloc(
        nearestTailorsRepository: sl(),
      ));

  //! Usecases

  //! Repository

  sl.registerLazySingleton(() => NearestTailorsRepository(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //! Data Sources

  sl.registerLazySingleton<NearestTailorsRemoteDataSource>(
      () => NearestTailorsRemoteDataSourceImpl(client: sl()));

  // //! Core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );

  //! External
}
