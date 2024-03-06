import 'package:equatable/equatable.dart';

class DeletePickUpDateResponse extends Equatable {
  final String message;

  const DeletePickUpDateResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
