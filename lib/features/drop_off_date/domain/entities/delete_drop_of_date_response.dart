import 'package:equatable/equatable.dart';

class DeleteDropOffDateResponse extends Equatable {
  final String message;

  const DeleteDropOffDateResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
