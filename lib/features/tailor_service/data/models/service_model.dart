// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required int categoryId,
    required double price,
    required String name,
    required String description,
    String? catagoryName,
    int? id,
  }) : super(
          categoryId: categoryId,
          description: description,
          name: name,
          price: price,
          id: id,
          catagoryName: catagoryName,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    print('jsssssssson: $json');
    final ServiceModel serviceModel = ServiceModel(
      // categoryId: (json['category_id'] as num).toInt(),
      // price: (json['price'] as num).toDouble(),
      // name: json['name'],
      // description: json['description'],
      // id: (json['id'] as num).toInt(),
      // catagoryName: "",
      categoryId: (json['category_id'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      catagoryName:
          json['category'] != null ? json['category']['name'] ?? '' : '',
    );
    debugPrint('-------------- serviceModel----------');
    debugPrint('-------------- serviceModel---------- $serviceModel');
    debugPrint('-------------- serviceModel----------');
    return serviceModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'price': price,
      'name': name,
      'description': description,
    };
  }
}
