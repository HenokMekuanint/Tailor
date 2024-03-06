import 'package:equatable/equatable.dart';

class DropOffDateEntity extends Equatable {
  final String dropOffDateTime;
  final int id;
  final int tailorId;

  const DropOffDateEntity(
      {required this.dropOffDateTime,
      required this.id,
      required this.tailorId});

  @override
  List<Object?> get props => [dropOffDateTime, id, tailorId];
}
