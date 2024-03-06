import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:mobile/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  // Create Order
  @override
  Future<Either<Failure, CreateOrderEntity>> createOrder(
      CreateOrderEntity order) async {
    if (await networkInfo.isConnected) {
      try {
        final createdOrder = await remoteDataSource.createOrder(order);
        return Right(createdOrder);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // Get Orders - User
  @override
  Future<Either<Failure, List<OrderEntity>>> userGetOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final orders = await remoteDataSource.userGetOrders();
        debugPrint('tailor editService response body: $orders');

        return Right(orders);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // Get Orders - Tailor
  @override
  Future<Either<Failure, List<OrderEntity>>> tailorGetOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final orders = await remoteDataSource.tailorGetOrders();
        debugPrint('tailor editService response body: $orders');

        return Right(orders);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  }

  // User Complete Payment
  Future<Either<Failure, OrderEntity>> userCompletePayment(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final createdOrder = await remoteDataSource.userCompletePayment(id);
        return Right(createdOrder);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(
        NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again',
        ),
      );
    }
  } 
}
