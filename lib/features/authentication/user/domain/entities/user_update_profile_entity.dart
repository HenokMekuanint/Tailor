import 'package:equatable/equatable.dart';

class UserUpdateProfileEntity extends Equatable {
  final String? name;

  final String? address;

  const UserUpdateProfileEntity({
    this.name,
    this.address,
  });

  @override
  List<Object?> get props => [
        name,
        address,
      ];
}
