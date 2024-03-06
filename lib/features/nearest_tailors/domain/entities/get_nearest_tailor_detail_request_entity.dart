import 'package:equatable/equatable.dart';

class GetNearestTailorRequestEntity extends Equatable {
  final int id;

  const GetNearestTailorRequestEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
