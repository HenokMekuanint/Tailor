import 'package:get_it/get_it.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:mobile/features/order/data/respositories/order_repo_impl.dart';
import 'package:mobile/features/order/domain/repository/order_repository.dart';
import 'package:mobile/features/order/domain/usecases/tailor_get_orders.dart';
import 'package:mobile/features/order/domain/usecases/userCompletePayment.dart';
import 'package:mobile/features/order/domain/usecases/user_create_order.dart';
import 'package:mobile/features/order/domain/usecases/user_get_orders.dart';
import 'package:mobile/features/order/presentation/bloc/order_bloc.dart';

final sl = GetIt.instance;
Future<void> orderInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => OrderBloc(
      createOrder: sl(),
      userGetOrders: sl(),
      tailorGetOrders: sl(),
      userCompletePayment: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => CreateOrder(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UserGetOrders(repository: sl()),
  );

  sl.registerLazySingleton(
    () => TailorGetOrders(repository: sl()),
  );
  sl.registerLazySingleton(
    () => UserCompletePayment(repository: sl()),
  );
  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(client: sl()),
  );
}
