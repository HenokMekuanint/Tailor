import 'package:dartz/dartz.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/core/errors/failures.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/categories/data/data_sources/remote_data_source/categories_remote_data_source.dart';
import 'package:mobile/features/categories/domain/entities/category_entity.dart';
import 'package:mobile/features/categories/domain/repositories/category_repository.dart';

class CategoriesRepositoryImpl extends CategoryRepository {
  final NetworkInfo networkInfo;

  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        return Right(remoteCategories);
      } on InternalServerException catch (e) {
        return Left(InternalServerFailure(message: e.message));
      } on UnAuthorizedException catch (e) {
        return Left(UnAuthorizedFailure(message: e.message));
      } on InvalidInputException catch (e) {
        return Left(InvalidInputFailure(message: e.message));
      } on NoInternetException catch (e) {
        return Left(NoInternetFailure(message: e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(message: e.message));
      } on ConnectionTimeoutException catch (e) {
        return Left(ConnectionTimeoutFailure(message: e.message));
      } on UnknownException catch (e) {
        return Left(UnknownFailure(message: e.message));
      }
    } else {
      return Left(throw NoInternetFailure(
          message:
              'No Internet connection. Please check your Internet connection and try again'));
    }
  }
}
