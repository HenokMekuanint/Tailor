import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/payment/domain/entities/tailor_stripe_connect_response.dart';
import 'package:mobile/features/payment/domain/usecases/tailor_create_stripe_account_link.dart';

part 'tailor_create_stripe_account_link_event.dart';
part 'tailor_create_stripe_account_link_state.dart';

class TailorCreateStripeAccountLinkBloc extends Bloc<
    TailorCreateStripeAccountLinkEvent, TailorCreateStripeAccountLinkState> {
  final TailorCreateStripeAccountLink createStripeAccountLink;

  TailorCreateStripeAccountLinkBloc({required this.createStripeAccountLink})
      : super(TailorCreateStripeAccountLinkInitial()) {
    on<CreateStripeLInk>(_createStripeAccountLink);
  }

  TailorCreateStripeAccountLinkState createAccountSuccessOrFailure(
      Either<Failure, TailorStripeConnectResponse> data) {
    return data.fold(
      (failure) =>
          TailorCreateStripeAccountLinkFailure(errorMessage: failure.message),
      (success) => TailorCreateStripeAccountLinkSuccess(
          tailorStripeConnectResponse: success),
    );
  }

  void _createStripeAccountLink(CreateStripeLInk event,
      Emitter<TailorCreateStripeAccountLinkState> emit) async {
    emit(TailorCreateStripeAccountLinkInitial());
    final result = await createStripeAccountLink();
    emit(createAccountSuccessOrFailure(result));
  }
}
