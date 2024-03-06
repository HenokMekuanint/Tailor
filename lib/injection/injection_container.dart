import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/injection/drop_off_date_injection.dart';
import 'package:mobile/injection/nearest_tailors_injection.dart';
import 'package:mobile/injection/payment_injection.dart';
import 'package:mobile/injection/persisted_shared_pref_manager.dart';
import 'package:mobile/injection/order_injection.dart';
import 'package:mobile/injection/pick_up_date_injection.dart';
import 'package:mobile/injection/tailor_save_fcm_token_injection.dart';
import 'package:mobile/injection/tailor_update_profile_pic_injection.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/injection/tailor_auth_injection.dart';
import 'package:mobile/injection/services_injection.dart';
import 'package:mobile/injection/shared_pref_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/injection/user_save_fcm_token_injection.dart';
import 'package:mobile/injection/user_update_profile_pic_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_categories_injection.dart';
import 'search_nearest_tailors_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User Auth
  await userAuthInjectionInit();

  //! Feature - Tailor Auth
  await tailorAuthInjectionInit();

  //! SharedPreferences Manager
  await initPrefManager();

  //! PersistedPreferencesManager
  await initPersistedSharePrefManager();

  //! Features - User Nearest Tailors
  await initNearestTailorsDepInj();

  //! Features Tailor Get Categories
  await initGetCategoriesDepInj();

  // Service Injection
  await serviceInjectionInit();

  // Order Injection
  await orderInjectionInit();

  // Tailor Pick Up Date Injection
  await initPickUpDateDepInj();

  // Tailor DropOff Date Injection
  await initDropOffDateDepInj();

  // ayment Injection
  await paymentInjectionInit();

  // Tailor Save Fcm Token Injection
  await tailorSaveFcmTokenInjectionInit();

  // User Save Fcm Token Injection
  await userSaveFcmTokenInjectionInit();

  // Tailor Update Profile Picture Injection
  await tailorUpdateProfilePicInjectionInit();

  // User Update Profile Picture Injection
  await userUpdateProfilePicInjectionInit();

  // User Search Nearest Tailors by Address Injection
  await initSearchNearestTailorsDepInj();

  //! Core - Network information
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //! External -Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
