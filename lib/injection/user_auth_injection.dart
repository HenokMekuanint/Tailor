import 'package:get_it/get_it.dart';
import 'package:mobile/features/authentication/user/data/datasources/user_auth_remote_datasources.dart';
import 'package:mobile/features/authentication/user/data/repository/user_auth_repo_impl.dart';
import 'package:mobile/features/authentication/user/domain/repository/user_auth_repo.dart';
import 'package:mobile/features/authentication/user/domain/usecases/get_logged_in_user_info.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_in_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_out_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/sign_up_user.dart';
import 'package:mobile/features/authentication/user/domain/usecases/update_profile_user.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';

final sl = GetIt.instance;
Future<void> userAuthInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => UserAuthBloc(
      signInUser: sl(),
      signOutUser: sl(),
      signUpUser: sl(),
      updateProfileUser: sl(),
      getLoggedInUserInfoLocal: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => SignUpUser(repository: sl()),
  );

  sl.registerLazySingleton(
    () => SignInUser(repository: sl()),
  );

  sl.registerLazySingleton(
    () => SignOutUser(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateProfileUser(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetLoggedInUserInfoLocal(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<UserAuthRemoteDataSource>(
    () => UserAuthRemoteDataSourceImpl(client: sl()),
  );

  //core
}
