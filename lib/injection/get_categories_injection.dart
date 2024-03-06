import 'package:get_it/get_it.dart';
import 'package:mobile/features/categories/data/data_sources/remote_data_source/categories_remote_data_source.dart';
import 'package:mobile/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:mobile/features/categories/domain/repositories/category_repository.dart';
import 'package:mobile/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:mobile/features/categories/presentation/bloc/categories_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initGetCategoriesDepInj() async {
  //! Bloc

  sl.registerFactory(() => CategoriesBloc(
        getCategoriesUseCase: sl(),
      ));

  //! Usecases

  sl.registerLazySingleton(() => GetCategoriesUseCase(
        repository: sl(),
      ));

  //! Repository

  sl.registerLazySingleton<CategoryRepository>(() => CategoriesRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //! Data Sources

  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(client: sl()));

  // //! Core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );

  //! External
}
