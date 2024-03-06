import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:mobile/features/order/domain/repository/order_repository.dart';

class UserGetOrders {
  final OrderRepository repository;
  UserGetOrders({required this.repository});

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await repository.userGetOrders();
  }
}
