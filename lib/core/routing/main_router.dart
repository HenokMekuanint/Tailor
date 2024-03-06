import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/notification_page.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/tailor_login_page.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/tailor_profile_detail.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/tailor_sign_up_page.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/update_profile_picture_screen.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/presentation/screens/update_profile_picture_screen.dart';
import 'package:mobile/features/authentication/user/presentation/screens/user_login_page.dart';
import 'package:mobile/features/authentication/user/presentation/screens/user_notification_screen.dart';
import 'package:mobile/features/authentication/user/presentation/screens/user_profile_page_detail.dart';
import 'package:mobile/features/authentication/user/presentation/screens/user_sign_up_page.dart';
import 'package:mobile/features/drop_off_date/domain/entities/drop_off_date_entity.dart';
import 'package:mobile/features/drop_off_date/presentation/screens/add_drop_off_date_screen.dart';
import 'package:mobile/features/drop_off_date/presentation/screens/edit_delete_drop_off_date_screen.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';

import 'package:mobile/features/nearest_tailors/presentation/screens/user_main_page.dart';

import 'package:mobile/features/nearest_tailors/presentation/screens/user_tailor_details_page.dart';

import 'package:mobile/features/home/tailor/presentation/tailor_main_page.dart';
import 'package:mobile/features/onboarding/presentation/onboarding_page.dart';
import 'package:mobile/features/onboarding/presentation/splash_screen.dart';
import 'package:mobile/features/order/domain/entities/order_entity.dart';
import 'package:mobile/features/order/presentation/screens/service_book_page.dart';
import 'package:mobile/features/order/presentation/screens/user_order_detail_page.dart';
import 'package:mobile/features/order/presentation/screens/tailor_order_detail_page.dart';
import 'package:mobile/features/pick_up_date/domain/entities/pick_up_date_entity.dart';
import 'package:mobile/features/pick_up_date/presentation/screens/add_pick_up_date_screen.dart';
import 'package:mobile/features/pick_up_date/presentation/screens/edit_delete_pick_up_date_screen.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/presentation/screens/tailor_add_service_page.dart';
import 'package:mobile/features/tailor_service/presentation/screens/tailor_edit_service_page.dart';
import 'package:mobile/features/tailor_service/presentation/screens/tailor_service_page.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class AppRouter {
  final prefManager = sl<SharedPrefManager>();

  late final GoRouter router = GoRouter(
    initialLocation: prefManager.getString(SharedPrefKeys.token) == null
        ? '/${AppRouteNames.onboarding}'
        : prefManager.getString(SharedPrefKeys.userType) == 'user'
            ? '/${AppRouteNames.userMainPage}'
            : '/${AppRouteNames.tailorHome}',
    // initialLocation: '/${AppRouteNames.tailorSignUpPage}',
    routes: [
      GoRoute(
        name: AppRouteNames.splashScreen,
        path: '/${AppRouteNames.splashScreen}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const SplashScreen(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.tailorServicePage,
        path: '/${AppRouteNames.tailorServicePage}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const TailorServicePage(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.userMainPage,
        path: '/${AppRouteNames.userMainPage}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const UserMainScreen(),
        ),
      ),
      // GoRoute(
      //   name: AppRouteNames.userHome,
      //   path: '/${AppRouteNames.userMainPage}',
      //   pageBuilder: (BuildContext context, GoRouterState state) =>
      //       buildCustomTransitionForPage(
      //     context,
      //     state,
      //     const UserMainPage(),
      //   ),
      // ),

      GoRoute(
        name: AppRouteNames.tailorLoginPage,
        path: '/${AppRouteNames.tailorLoginPage}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const TailorLoginPage(),
        ),
      ),

      GoRoute(
        name: AppRouteNames.tailorSignUpPage,
        path: '/${AppRouteNames.tailorSignUpPage}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const TailorSignUpPage(),
        ),
      ),

      GoRoute(
          name: AppRouteNames.tailorNotificationDetailPage,
          path: '/${AppRouteNames.tailorNotificationDetailPage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final notice = state.extra as Map<String, String>;
            return buildCustomTransitionForPage(
              context,
              state,
              TailorNotificationScreen(
                notice: notice,
              ),
            );
          }),
      GoRoute(
          name: AppRouteNames.userNotificationDetailPage,
          path: '/${AppRouteNames.userNotificationDetailPage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final notice = state.extra as Map<String, String>;
            return buildCustomTransitionForPage(
              context,
              state,
              UserNotificationScreen(
                notice: notice,
              ),
            );
          }),

      GoRoute(
          name: AppRouteNames.tailorHome,
          path: '/${AppRouteNames.tailorHome}',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              buildCustomTransitionForPage(
                context,
                state,
                const tailorMainPage(),
              ),
          routes: [
            // TODO: Add tailor stripe account create success page

            GoRoute(
                name: AppRouteNames.stripeConnectSuccessPage,
                path: '${AppRouteNames.stripeConnectSuccessPage}/:id',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  print("path is ${state.uri.path}");
                  final response = state.pathParameters['id'];
                  print("The result is $response");

                  return buildCustomTransitionForPage(
                      context,
                      state,
                      Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Success',
                            style: TextStyle(color: Colors.black),
                          ),
                          centerTitle: true,
                        ),
                        backgroundColor: Colors.white,
                        body: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            child: Column(
                              children: [
                                Text(
                                  'You have successfully connected your stripe account.',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Text("Your Stripe Account ID is: "),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    '$response',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
            // TODO: Add tailor stripe account create failure page
            GoRoute(
                name: AppRouteNames.stripeConnectFailurePage,
                path: '${AppRouteNames.stripeConnectFailurePage}',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return buildCustomTransitionForPage(
                      context,
                      state,
                      Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Failure',
                            style: TextStyle(color: Colors.red),
                          ),
                          centerTitle: true,
                        ),
                        backgroundColor: Colors.white,
                        body: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 50),
                            child: Column(
                              children: [
                                Text(
                                  'Tailor stripe account connecting failed. Please try later',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ]),
      GoRoute(
        name: AppRouteNames.userSignUp,
        path: '/${AppRouteNames.userSignUp}',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildCustomTransitionForPage(
          context,
          state,
          const UserSignUpPage(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.userLogin,
        path: '/${AppRouteNames.userLogin}',
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
        ) {
          return buildCustomTransitionForPage(
            context,
            state,
            const UserLoginPage(),
          );
        },
      ),
      // GoRoute(
      //     name: AppRouteNames.userSignUp,
      //     path: '/${AppRouteNames.userSignUp}',
      //     pageBuilder: (BuildContext context, GoRouterState state) =>
      //         buildCustomTransitionForPage(
      //             context, state, const UserSignUpPage())),
      GoRoute(
        name: AppRouteNames.userOrderDetailPage,
        path: '/${AppRouteNames.userOrderDetailPage}',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final orderEntity = state.extra as OrderEntity;
          return buildCustomTransitionForPage(
            context,
            state,
            clientOrderDetailPage(
              order: orderEntity,
            ),
          );
        },
      ),
      GoRoute(
          name: AppRouteNames.onboarding,
          path: '/${AppRouteNames.onboarding}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const OnBoarding());
          }),

      GoRoute(
          name: AppRouteNames.userTailorDetailPage,
          path: '/${AppRouteNames.userTailorDetailPage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final mapData = state.extra as Map<String, dynamic>;
            final tailorId = mapData['tailorId'] as int;
            final distance = (mapData['distance'] as num).toDouble();
            return buildCustomTransitionForPage(
                context,
                state,
                UserTailorDetailsScreen(
                  tailorId: tailorId,
                  distance: distance,
                ));
          }),
      GoRoute(
          name: AppRouteNames.tailorAddPickUpDateScreen,
          path: '/${AppRouteNames.tailorAddPickUpDateScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const TailorAddPickUpDateScreen());
          }),
      GoRoute(
          name: AppRouteNames.tailorEditPickUpDateScreen,
          path: '/${AppRouteNames.tailorEditPickUpDateScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final pickUpDateEntity = state.extra as PickUpDateEntity;
            return buildCustomTransitionForPage(
                context,
                state,
                TailorEditDeletePickUpDateScreen(
                    pickUpDateEntity: pickUpDateEntity));
          }),
      GoRoute(
          name: AppRouteNames.tailorEditDropOffDateScreen,
          path: '/${AppRouteNames.tailorEditDropOffDateScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final dropOffDateEntity = state.extra as DropOffDateEntity;
            return buildCustomTransitionForPage(
                context,
                state,
                TailorEditDeleteDropOffDateScreen(
                    dropOffDateEntity: dropOffDateEntity));
          }),

      GoRoute(
          name: AppRouteNames.tailorAddDropOffDateScreen,
          path: '/${AppRouteNames.tailorAddDropOffDateScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const TailorAddDropOffDateScreen());
          }),

      GoRoute(
          name: AppRouteNames.userProfileDetailScreen,
          path: '/${AppRouteNames.userProfileDetailScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const UserProfileDetailPage());
          }),
      GoRoute(
          name: AppRouteNames.tailorProfileDetailScreen,
          path: '/${AppRouteNames.tailorProfileDetailScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const TailorProfileDetail());
          }),
      GoRoute(
          name: AppRouteNames.tailorOrderDetailPage,
          path: '/${AppRouteNames.tailorOrderDetailPage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final orderEntity = state.extra as OrderEntity;
            return buildCustomTransitionForPage(
                context,
                state,
                TailorOrderDetailPage(
                  order: orderEntity,
                ));
          }),
      GoRoute(
          name: AppRouteNames.tailorServiceDetailPage,
          path: '/${AppRouteNames.tailorServiceDetailPage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final serviceEntity = state.extra as ServiceEntity;
            return buildCustomTransitionForPage(
                context,
                state,
                EditServicePage(
                  service: serviceEntity,
                ));
          }),

      GoRoute(
          name: AppRouteNames.tailorAddServicePage,
          path: '/${AppRouteNames.tailorAddServicePage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransitionForPage(
                context, state, const TailorAddService());
          }),
      GoRoute(
          name: AppRouteNames.userBookServicePage,
          path: '/${AppRouteNames.userBookServicePage}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final nearestTailorDetails = state.extra as NearestTailorDetail;
            return buildCustomTransitionForPage(
                context,
                state,
                ServiceBookPage(
                  tailorDetail: nearestTailorDetails,
                ));
          }),

      GoRoute(
          name: AppRouteNames.userUpdateProfilePictureScreen,
          path: '/${AppRouteNames.userUpdateProfilePictureScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final UserModel? userModel = state.extra as UserModel?;
            return buildCustomTransitionForPage(
                context,
                state,
                UserUpdateProfilePictureScreen(
                  loggedInUser: userModel,
                ));
          }),
      GoRoute(
          name: AppRouteNames.tailorUpdateProfilePictureScreen,
          path: '/${AppRouteNames.tailorUpdateProfilePictureScreen}',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final TailorModel? tailorModel = state.extra as TailorModel?;
            return buildCustomTransitionForPage(
                context,
                state,
                TailorUpdateProfilePictureScreen(
                  loggedInTailor: tailorModel,
                ));
          }),
    ],
  );

  CustomTransitionPage<dynamic> buildCustomTransitionForPage(
      BuildContext context, GoRouterState state, Widget page) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionDuration: const Duration(seconds: 0),
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}
