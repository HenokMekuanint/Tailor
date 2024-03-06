import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/tailor/data/datasources/tailor_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/tailor/data/repository/tailor_auth_repo_impl.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/save_fcm_token.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/save_fcm_token/tailor_save_fcm_token_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> tailorSaveFcmTokenInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => TailorSaveFcmTokenBloc(
      saveFcmTokenUseCase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => TailorSaveFcmTokenUseCase(repository: sl()),
  );

  // Repository
  // sl.registerLazySingleton<TailorAuthRepository>(
  //   () => TailorAuthRepositoryImpl(
  //     remoteDataSource: sl(),
  //     networkInfo: sl(),
  //   ),
  // );

  // // Data Sources
  // sl.registerLazySingleton<TailorAuthRemoteDataSource>(
  //   () => TailorAuthRemoteDataSourceImpl(client: sl()),
  // );

  //core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );
}
