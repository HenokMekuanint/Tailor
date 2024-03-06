import 'package:mobile/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] ?? -1,
        name: json['name'] ?? 'No category name',
        createdAt: json['created_at'] ?? '12-12-2013',
        updatedAt: json['updated_at'] ?? '12-12-2013');
  }
}
