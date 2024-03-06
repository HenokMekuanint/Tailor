import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/tailor/data/datasources/tailor_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/tailor/data/repository/tailor_auth_repo_impl.dart';
import 'package:mobile/features/authentication/tailor/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/get_logged_in_user_info.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_in_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_out_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/sign_up_tailor.dart';
import 'package:mobile/features/authentication/tailor/domain/usecases/update_profile_tailor.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/tailor_auth_bloc.dart';

final sl = GetIt.instance;
Future<void> tailorAuthInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => TailorAuthBloc(
      signInTailor: sl(),
      signOutTailor: sl(),
      signUpTailor: sl(),
      updateProfileTailor: sl(),
      getLoggedInTailorInfoLocal: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => SignUpTailor(repository: sl()),
  );

  sl.registerLazySingleton(
    () => SignInTailor(repository: sl()),
  );

  sl.registerLazySingleton(
    () => SignOutTailor(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateProfileTailor(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetLoggedInTailorInfoLocal(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<TailorAuthRepository>(
    () => TailorAuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<TailorAuthRemoteDataSource>(
    () => TailorAuthRemoteDataSourceImpl(client: sl()),
  );

  //core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );
}
