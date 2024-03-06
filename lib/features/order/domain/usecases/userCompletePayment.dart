import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:mobile/features/order/domain/repository/order_repository.dart';

class UserCompletePayment {
  final OrderRepository repository;
  UserCompletePayment({required this.repository});

  Future<Either<Failure, OrderEntity>> call(String id) async {
    return await repository.userCompletePayment(id);
  }
}
