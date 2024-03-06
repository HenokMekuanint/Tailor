import 'package:equatable/equatable.dart';

class CreatePickUpDateResponseEntity extends Equatable {
  final String message;

  const CreatePickUpDateResponseEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
