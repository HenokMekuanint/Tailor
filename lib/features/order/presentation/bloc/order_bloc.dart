import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:mobile/features/order/domain/usecases/tailor_get_orders.dart';
import 'package:mobile/features/order/domain/usecases/userCompletePayment.dart';
import 'package:mobile/features/order/domain/usecases/user_create_order.dart';
import 'package:mobile/features/order/domain/usecases/user_get_orders.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrder createOrder;
  final UserGetOrders userGetOrders;
  final TailorGetOrders tailorGetOrders;
  final UserCompletePayment userCompletePayment;

  OrderState createOrderSuccessOrFailure(
      Either<Failure, CreateOrderEntity> data) {
    return data.fold(
      (failure) => OrderFailureState(failureMessage: failure.message),
      (success) => CreateOrderSuccessState(order: success),
    );
  }

  OrderState orderSuccessOrFailure(Either<Failure, List<OrderEntity>> data) {
    return data.fold(
      (failure) => OrderFailureState(failureMessage: failure.message),
      (success) => OrderSuccessState(orders: success),
    );
  }

  OrderState singleOrderSuccessOrFailure(Either<Failure, OrderEntity> data) {
    return data.fold(
      
      (failure) => CompletePaymentFailureState(failureMessage: failure.message),
      (success) => CompletePaymentSuccessState(order: success),
    );
  }

  void _createOrder(CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    final result = await createOrder(event.order);
    emit(createOrderSuccessOrFailure(result));
  }

  void _getUserOrders(
      UserGetOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    final result = await userGetOrders();
    emit(orderSuccessOrFailure(result));
  }

  void _getTailorOrders(
      TailorGetOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    final result = await tailorGetOrders();
    emit(orderSuccessOrFailure(result));
  }

  void _userCompletePayment(
      UserCompletePaymentEvent event, Emitter<OrderState> emit) async {
    emit(CompletePaymentLoadingState());
    final result = await userCompletePayment(event.id);
    emit(singleOrderSuccessOrFailure(result));
  }

  OrderBloc({
    required this.createOrder,
    required this.tailorGetOrders,
    required this.userGetOrders,
    required this.userCompletePayment,
  }) : super(OrderInitialState()) {
    on<CreateOrderEvent>(_createOrder);
    on<UserGetOrdersEvent>(_getUserOrders);
    on<TailorGetOrdersEvent>(_getTailorOrders);
    on<UserCompletePaymentEvent>(_userCompletePayment);
  }
}
