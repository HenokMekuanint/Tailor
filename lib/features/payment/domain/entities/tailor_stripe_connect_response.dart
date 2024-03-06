// ignore_for_file: non_constant_identifier_messages, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class TailorStripeConnectResponse extends Equatable {
  final String message;
  final String accountId;
  final String accountLink;

  TailorStripeConnectResponse({
    required this.message,
    required this.accountId,
    required this.accountLink,
  }) : super();

  @override
  List<Object> get props => [message, accountId];
}
