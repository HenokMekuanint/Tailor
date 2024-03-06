part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final CreateOrderEntity order;
  CreateOrderEvent({required this.order});
}

class UserGetOrdersEvent extends OrderEvent {}

class TailorGetOrdersEvent extends OrderEvent {}

class UserCompletePaymentEvent extends OrderEvent {
  final String id;
  UserCompletePaymentEvent({required this.id});
}
