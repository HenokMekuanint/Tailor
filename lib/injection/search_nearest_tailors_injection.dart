import 'package:get_it/get_it.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/search_nearest_tailors_bloc/search_nearest_tailors_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initSearchNearestTailorsDepInj() async {
  //! Bloc
  sl.registerFactory(() => SearchNearestTailorsBloc(
        nearestTailorsRepository: sl(),
      ));

  //! Usecases

  //! Repository

  //! Data Sources

  //! External
}
