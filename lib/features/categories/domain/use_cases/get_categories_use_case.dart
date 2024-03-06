import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/use_cases/use_case.dart';
import 'package:mobile/features/categories/domain/entities/category_entity.dart';
import 'package:mobile/features/categories/domain/repositories/category_repository.dart';

class GetCategoriesUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
