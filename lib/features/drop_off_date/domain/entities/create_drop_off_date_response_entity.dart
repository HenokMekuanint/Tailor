import 'package:equatable/equatable.dart';

class CreateDropOffDateResponseEntity extends Equatable {
  final String message;

  const CreateDropOffDateResponseEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
