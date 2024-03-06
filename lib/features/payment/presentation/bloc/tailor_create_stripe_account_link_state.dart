part of 'tailor_create_stripe_account_link_bloc.dart';

abstract class TailorCreateStripeAccountLinkState extends Equatable {
  const TailorCreateStripeAccountLinkState();

  @override
  List<Object> get props => [];
}

class TailorCreateStripeAccountLinkInitial
    extends TailorCreateStripeAccountLinkState {}

class TailorCreateStripeAccountLinkLoading
    extends TailorCreateStripeAccountLinkState {}

class TailorCreateStripeAccountLinkSuccess
    extends TailorCreateStripeAccountLinkState {
  final TailorStripeConnectResponse tailorStripeConnectResponse;

  const TailorCreateStripeAccountLinkSuccess(
      {required this.tailorStripeConnectResponse});
}

class TailorCreateStripeAccountLinkFailure
    extends TailorCreateStripeAccountLinkState {
  final String errorMessage;

  const TailorCreateStripeAccountLinkFailure(
      {required this.errorMessage});
}
