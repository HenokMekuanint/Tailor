import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message) : super(message: message);
}

class InputFailure extends Failure {
  final String message;
  InputFailure(this.message) : super(message: message);
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure(this.message) : super(message: message);
}

class NoInternetFailure extends Failure {
  final String message;
  NoInternetFailure({required this.message}) : super(message: message);
}

class UnknownFailure extends Failure {
  final String message;
  UnknownFailure({required this.message}) : super(message: message);
}

class UnAuthorizedFailure extends Failure {
  final String message;
  UnAuthorizedFailure({required this.message}) : super(message: message);
}

class InvalidInputFailure extends Failure {
  final String message;
  InvalidInputFailure({required this.message}) : super(message: message);
}

class InternalServerFailure extends Failure {
  final String message;
  InternalServerFailure({required this.message}) : super(message: message);
}

class NotFoundFailure extends Failure {
  final String message;
  NotFoundFailure({required this.message}) : super(message: message);
}

class ConnectionTimeoutFailure extends Failure {
  final String message;
  ConnectionTimeoutFailure({required this.message}) : super(message: message);
}
