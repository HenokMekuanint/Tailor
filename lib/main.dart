import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile/core/routing/main_router.dart';
import 'package:mobile/env/env.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/save_fcm_token/tailor_save_fcm_token_bloc.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/tailor_auth_bloc.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/update_profile_pic/tailor_update_profile_pic_bloc.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/save_fcm_token/user_save_fcm_token_bloc.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/update_profile_pic/user_update_profile_pic_bloc.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/user_auth_bloc.dart';
import 'package:mobile/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:mobile/features/drop_off_date/presentation/bloc/drop_off_date_bloc.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/search_nearest_tailors_bloc/search_nearest_tailors_bloc.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/user_nearest_tailors_bloc.dart';
import 'package:mobile/features/order/presentation/bloc/order_bloc.dart';

import 'package:mobile/features/payment/presentation/bloc/tailor_create_stripe_account_link_bloc.dart';
import 'package:mobile/features/pick_up_date/presentation/bloc/pick_up_date_bloc.dart';
import 'package:mobile/features/tailor_service/presentation/bloc/service_bloc.dart';
import 'package:mobile/firebase_options.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';
import './injection/injection_container.dart' as di;
import 'core/constants/shared_pref_keys.dart';
import 'observers/bloc_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  debugPrint('Handling a background message ${remoteMessage.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  final prefManager = sl<SharedPrefManager>();

  // prefManager.clear();

  debugPrint('token is ${prefManager.getString(SharedPrefKeys.token)}');
  debugPrint('usertype is ${prefManager.getString(SharedPrefKeys.userType)}');
  Stripe.publishableKey = Env.stripeTestPublishableKey;
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<UserAuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<TailorAuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<UserNearestTailorsBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<CategoriesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<ServiceBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<OrderBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<DropOffDateBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<PickUpDateBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<TailorCreateStripeAccountLinkBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<TailorSaveFcmTokenBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<UserSaveFcmTokenBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<TailorUpdateProfilePicBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<UserUpdateProfilePicBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<SearchNearestTailorsBloc>(),
          ),
        ],
        child: MaterialApp.router(
          builder: EasyLoading.init(),
          routerConfig: AppRouter().router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
