import 'package:shared_preferences/shared_preferences.dart';

class PersistedSharePrefManager {
  PersistedSharePrefManager(this.sharedPreferences);
  SharedPreferences sharedPreferences;

  final String _kIsLocationEnableAndShared = 'isLocationEnableAndShared';

  // Setter for isLocationEnableAndShared
  set isLocationEnableAndShared(bool? value) =>
      sharedPreferences.setBool(_kIsLocationEnableAndShared, value ?? false);

  // Getter for isLocationEnableAndShared
  bool? get isLocationEnableAndShared =>
      sharedPreferences.getBool(_kIsLocationEnableAndShared);
}
