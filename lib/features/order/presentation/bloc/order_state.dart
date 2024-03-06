part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class CreateOrderSuccessState extends OrderState {
  final CreateOrderEntity order;

  CreateOrderSuccessState({required this.order});
}

final class OrderSuccessState extends OrderState {
  final List<OrderEntity> orders;

  OrderSuccessState({required this.orders});
}

final class OrderFailureState extends OrderState {
  final String failureMessage;
  OrderFailureState({required this.failureMessage});
}

final class CompletePaymentLoadingState extends OrderState {}

final class CompletePaymentSuccessState extends OrderState {
  final OrderEntity order;
  CompletePaymentSuccessState({required this.order});
}

final class CompletePaymentFailureState extends OrderState {
  final String failureMessage;
  CompletePaymentFailureState({required this.failureMessage});
}
