
import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/update_profile_picture.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/update_profile_pic/tailor_update_profile_pic_bloc.dart';

GetIt sl = GetIt.instance;
Future<void> tailorUpdateProfilePicInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => TailorUpdateProfilePicBloc(
      tailorUpdateProfilePictureUseCase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => TailorUpdateProfilePictureUseCase(repository: sl()),
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