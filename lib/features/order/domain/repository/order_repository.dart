import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, CreateOrderEntity>> createOrder(
      CreateOrderEntity order);

  Future<Either<Failure, List<OrderEntity>>> userGetOrders();
  Future<Either<Failure, List<OrderEntity>>> tailorGetOrders();
  Future<Either<Failure, OrderEntity>> userCompletePayment(String id);
}
