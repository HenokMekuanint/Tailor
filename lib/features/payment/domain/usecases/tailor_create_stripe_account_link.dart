import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/payment/domain/entities/tailor_stripe_connect_response.dart';
import 'package:mobile/features/payment/domain/repositories/stripe_payment_repository.dart';

class TailorCreateStripeAccountLink {
  final StripePaymentRepository repository;
  TailorCreateStripeAccountLink({required this.repository});

  Future<Either<Failure, TailorStripeConnectResponse>> call() async {
    return await repository.tailorCreateStripeAccountLink();
  }
}
