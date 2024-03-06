// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  int? id;
  int categoryId;
  double price;
  String name;
  String? catagoryName;
  String description;

  ServiceEntity({
    required this.categoryId,
    required this.price,
    required this.name,
    required this.description,
    this.id,
    this.catagoryName,
  }) : super();

  @override
  List<Object?> get props => [name, categoryId, catagoryName];
}
