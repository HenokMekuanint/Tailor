import 'package:get_it/get_it.dart';
import 'package:mobile/shared_pref/persisted_shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create an instance of GetIt for dependency injection
GetIt sl = GetIt.instance;

// Initialize the PersistedSharePrefManager for managing persisted shared preferences
Future<void> initPersistedSharePrefManager() async {
  SharedPreferences persistedSharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<PersistedSharePrefManager>(
      () => PersistedSharePrefManager(persistedSharedPreferences));
}
