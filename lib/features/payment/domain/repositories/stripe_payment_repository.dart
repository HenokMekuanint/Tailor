// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/payment/domain/entities/tailor_stripe_connect_response.dart';

abstract class StripePaymentRepository {
  Future<Either<Failure, TailorStripeConnectResponse>>
      tailorCreateStripeAccountLink();
}
