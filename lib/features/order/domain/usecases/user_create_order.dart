import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/features/order/domain/repository/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;
  CreateOrder({required this.repository});

  Future<Either<Failure, CreateOrderEntity>> call(
      CreateOrderEntity order) async {
    return await repository.createOrder(order);
  }
}
