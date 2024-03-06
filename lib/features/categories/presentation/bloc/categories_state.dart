part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesInitialState extends CategoriesState {}

final class GetCategoriesLoadingState extends CategoriesState {}

final class GetCategoriesLoadedState extends CategoriesState {
  final List<CategoryEntity> categories;

  const GetCategoriesLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class GetCategoriesErrorState extends CategoriesState {
  final String message;

  const GetCategoriesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
