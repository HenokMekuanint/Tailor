import 'package:get_it/get_it.dart';
import 'package:mobile/features/payment/data/datasources/payment_datasource.dart';
import 'package:mobile/features/payment/data/repositories/stripe_payment_repo_impl.dart';
import 'package:mobile/features/payment/domain/repositories/stripe_payment_repository.dart';
import 'package:mobile/features/payment/domain/usecases/tailor_create_stripe_account_link.dart';
import 'package:mobile/features/payment/presentation/bloc/tailor_create_stripe_account_link_bloc.dart';

final sl = GetIt.instance;
Future<void> paymentInjectionInit() async {
  // Bloc
  sl.registerFactory(
    () => TailorCreateStripeAccountLinkBloc(
      createStripeAccountLink: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(
    () => TailorCreateStripeAccountLink(repository: sl()),
  );
  // Repository
  sl.registerLazySingleton<StripePaymentRepository>(
    () => StripePaymentRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<StripePaymentDataSource>(
    () => StripePaymentDataSourceImpl(client: sl()),
  );
}
