import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheException extends Equatable implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  List<Object?> get props => [message];
}

class UserNotFoundException extends Equatable implements Exception {
  final String message;

  const UserNotFoundException(this.message);

  @override
  List<Object?> get props => [message];
}

class InputException extends Equatable implements Exception {
  final String message;

  const InputException(this.message);

  @override
  List<Object?> get props => [message];
}

class NoInternetException extends Equatable implements Exception {
  final String message;
  const NoInternetException({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnAuthorizedException extends Equatable implements Exception {
  final String message;
  const UnAuthorizedException({required this.message});

  @override
  List<Object?> get props => [message];
}

class InvalidInputException extends Equatable implements Exception {
  final String message;
  const InvalidInputException({required this.message});

  @override
  List<Object?> get props => [message];
}

class InternalServerException extends Equatable implements Exception {
  final String message;
  const InternalServerException({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnknownException extends Equatable implements Exception {
  final String message;
  const UnknownException({required this.message});

  @override
  List<Object?> get props => [message];
}

class ConnectionTimeoutException extends Equatable implements Exception {
  final String message;
  const ConnectionTimeoutException({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotFoundException extends Equatable implements Exception {
  final String message;
  const NotFoundException({required this.message});

  @override
  List<Object?> get props => [message];
}
