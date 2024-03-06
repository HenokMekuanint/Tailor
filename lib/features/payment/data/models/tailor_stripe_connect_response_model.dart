import 'package:mobile/features/payment/domain/entities/tailor_stripe_connect_response.dart';

class TailorStripeConnectResonseModel extends TailorStripeConnectResponse {
  TailorStripeConnectResonseModel({
    required String message,
    required String accountId,
    required String accountLink,
  }) : super(
          message: message,
          accountId: accountId,
          accountLink: accountLink,
        );

  factory TailorStripeConnectResonseModel.fromJson(Map<String, dynamic> json) {
    return TailorStripeConnectResonseModel(
      message: json['message'] ?? '',
      accountId: json['account_id'] ?? '',
      accountLink: json['accountLink'] ?? '',
    );
  }
}
