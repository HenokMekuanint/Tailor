import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/user/data/datasources/user_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/user/data/repository/user_auth_repo_impl.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/authentication/user/domain/usecases/save_fcm_token.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/save_fcm_token/user_save_fcm_token_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> userSaveFcmTokenInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => UserSaveFcmTokenBloc(
      saveFcmTokenUseCase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => UserSaveFcmTokenUseCase(repository: sl()),
  );

  // Repository
  // sl.registerLazySingleton<UserAuthRepository>(
  //   () => UserAuthRepositoryImpl(
  //     remoteDataSource: sl(),
  //     networkInfo: sl(),
  //   ),
  // );

  // // Data Sources
  // sl.registerLazySingleton<UserAuthRemoteDataSource>(
  //   () => UserAuthRemoteDataSourceImpl(client: sl()),
  // );

  //core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );
}
