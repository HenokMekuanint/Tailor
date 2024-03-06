import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/payment/data/datasources/payment_datasource.dart';
import 'package:mobile/features/payment/domain/entities/tailor_stripe_connect_response.dart';
import 'package:mobile/features/payment/domain/repositories/stripe_payment_repository.dart';

class StripePaymentRepositoryImpl implements StripePaymentRepository {
  final StripePaymentDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StripePaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, TailorStripeConnectResponse>>
      tailorCreateStripeAccountLink() async {
    if (await networkInfo.isConnected) {
      try {
        final createdAccount =
            await remoteDataSource.tailorCreateStripeAccountLink();
        return Right(createdAccount);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
