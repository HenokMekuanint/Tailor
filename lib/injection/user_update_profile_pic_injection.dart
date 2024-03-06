import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/user/domain/usecases/update_profile_picture.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/update_profile_pic/user_update_profile_pic_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> userUpdateProfilePicInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => UserUpdateProfilePicBloc(
      userUpdateProfilePicUseCase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => UserUpdateProfilePicUseCase(userAuthRepository: sl()),
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
