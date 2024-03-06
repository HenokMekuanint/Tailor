import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/presentation/bloc/save_fcm_token/user_save_fcm_token_bloc.dart';

import 'package:mobile/features/home/client/presentation/widgets/tailor_home_page_Card.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailors_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/search_nearest_tailors_by_address_request_model.dart';
import 'package:mobile/features/nearest_tailors/presentation/bloc/search_nearest_tailors_bloc/search_nearest_tailors_bloc.dart';

import 'package:mobile/features/nearest_tailors/presentation/bloc/user_nearest_tailors_bloc.dart';
import 'package:mobile/injection/get_categories_injection.dart';

import 'package:mobile/shared_pref/shared_pref_manager.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final prefManager = sl<SharedPrefManager>();
  TextEditingController _searchFieldController = TextEditingController();
  bool _isSearching = false;
  String? searchText;

  void getLoggedInUserInfo() {
    String? loggedInUserString =
        prefManager.getString(SharedPrefKeys.loggedInUserInfo);

    if (loggedInUserString != null && loggedInUserString.isNotEmpty) {
      loggedInUser = UserModel.fromJson(jsonDecode(loggedInUserString));
    }
  }

  @override
  void initState() {
    super.initState();
    final GetNearestTailorsRequestModel getNearestTailorsRequestEntity =
        GetNearestTailorsRequestModel(
            latitude: prefManager.getDouble(SharedPrefKeys.latitude) ?? 0.0,
            longitude: prefManager.getDouble(SharedPrefKeys.longitude) ?? 0.0);
    BlocProvider.of<UserNearestTailorsBloc>(context).add(GetNearestTailorsEvent(
        getNearestTailorsRequestModel: getNearestTailorsRequestEntity));

    getLoggedInUserInfo();
    getFcmToken();
    initInfo();
  }

  UserModel? loggedInUser;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String savedFcmToken = prefManager.getString(SharedPrefKeys.fcmToken) ?? "";
    debugPrint('user home device fcm token is $token');
    debugPrint('logged in fcm token is ${savedFcmToken}');
    if ((loggedInUser != null && savedFcmToken.isEmpty) ||
        (savedFcmToken != token)) {
      if (token != null) {
        if (prefManager.getString(SharedPrefKeys.userType) == 'user') {
          BlocProvider.of<UserSaveFcmTokenBloc>(context)
              .add(SaveUserFcmTokenEvent(fcmToken: token));
        }
      }
    }
  }

  initInfo() {
    var androidInitializer =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    var iosInitializer = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializer, iOS: iosInitializer);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: notificationTap);

// for display message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message body: ${message.notification?.body}');

      if (message.notification != null) {
        debugPrint('Message title: ${message.notification?.title}');
      }

      BigTextStyleInformation styleInformation = BigTextStyleInformation(
          message.notification?.body.toString() ?? "",
          htmlFormatBigText: true,
          contentTitle: message.notification?.title.toString(),
          htmlFormatContentTitle: true);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails("ThreadMe", "ThreadMe",
              importance: Importance.high,
              styleInformation: styleInformation,
              priority: Priority.high,
              playSound: true);
      DarwinNotificationDetails iOSNotificationDetails =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        presentBanner: true,
        threadIdentifier: 'ThreadMe',
      );

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: iOSNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails,
          payload: message.data['body']);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint(
          'On open app Message data title: ${message.notification?.title}');

      if (message.notification != null) {
        debugPrint('on open app Message body: ${message.notification?.body}');

        if (prefManager.getString(SharedPrefKeys.userType) == 'user') {
          context.pushNamed(AppRouteNames.userNotificationDetailPage, extra: {
            'body': message.notification?.body ?? "No notification Body",
            'title': message.notification?.title ?? "No notification Title",
          });
        } else if (prefManager.getString(SharedPrefKeys.userType) == 'tailor') {
          context.pushNamed(AppRouteNames.tailorNotificationDetailPage, extra: {
            'body': message.notification?.body ?? "No notification Body",
            'title': message.notification?.title ?? "No notification Title",
          });
        }
      }
    });
  }

  void notificationTap(
    NotificationResponse notificationResponse,
  ) {
    final data = jsonDecode(notificationResponse.payload ?? "");
    debugPrint('notification tap');
    debugPrint('notification payload data is $data');

    if (prefManager.getString(SharedPrefKeys.userType) == 'user') {
      context.pushNamed(AppRouteNames.userNotificationDetailPage, extra: {
        'body': data['body'] ?? "No notification Body",
        'title': data['title'] ?? "No notification Title",
      });
    } else if (prefManager.getString(SharedPrefKeys.userType) == 'tailor') {
      context.pushNamed(AppRouteNames.tailorNotificationDetailPage, extra: {
        'body': data['body'] ?? "No notification Body",
        'title': data['title'] ?? "No notification Title",
      });
    }
  }

  void handleSearchTailors() {
    debugPrint('handleSearchTailors called');
    debugPrint(
        'the search text from the controller is ${_searchFieldController.text}');

    if (_searchFieldController.text.isNotEmpty) {
      debugPrint('Adding search tailors event');
      final SearchNearestTailorsByAddressRequestModel searchModel =
          SearchNearestTailorsByAddressRequestModel(
              queryString: _searchFieldController.text,
              latitude: prefManager.getDouble(SharedPrefKeys.latitude) ?? 0.0,
              longitude:
                  prefManager.getDouble(SharedPrefKeys.longitude) ?? 0.0);
      BlocProvider.of<SearchNearestTailorsBloc>(context)
          .add(SearchNearestTailorsByAddressEvent(searchModel: searchModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Tailors in your area",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  // width: .w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFECECEC),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: TextFormField(
                      controller: _searchFieldController,
                      onChanged: (value) {
                        debugPrint('Search query string is: $value');
                        setState(() {
                          _isSearching = true;
                          searchText = value;
                        });

                        handleSearchTailors();
                      },
                      style: TextStyle(
                        fontSize: 20.h,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30.r,
                          ),
                          contentPadding: EdgeInsets.only(left: 5, top: 10),
                          hintText: "Address",
                          hintStyle: TextStyle(fontSize: 20.h)),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //     left: 20.w,
            //   ),
            //   child: Text(
            //     "Tailors in your area",
            //     style: TextStyle(fontFamily: "Roboto-Medium", fontSize: 25.h),
            //   ),
            // ),
            // SizedBox(
            //   height: 5.h,
            // ),
            (searchText == null || searchText!.isEmpty)
                ? BuildNearestTailorsBlocConsumerWidget()
                : BuildSearchNearestTailorsByAddressBlocConsumerWidget(),
          ],
        ),
      ),
    );
  }
}

class BuildNearestTailorsBlocConsumerWidget extends StatelessWidget {
  const BuildNearestTailorsBlocConsumerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<UserNearestTailorsBloc, UserNearestTailorsState>(
        listener: (context, state) {
          if (state is UserNearestTailorsErrorState) {
            EasyLoading.showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is UserNearestTailorsErrorState) {
            return Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
              child: Center(child: Text(state.message)),
            );
          } else if (state is UserNearestTailorsLoadedSuccessState) {
            if (state.nearestTailors.nearestTailors!.isEmpty) {
              return Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
                  child: Center(
                    child: Text(
                      'There are no tailors in your area at the moment!',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Roboto-Regular",
                          fontSize: 20.h,
                          color: const Color(0xFF000080)),
                    ),
                  ));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.nearestTailors.nearestTailors?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        debugPrint(
                            'Tailor Id is: ${state.nearestTailors.nearestTailors![index].id}');
                        context.goNamed(AppRouteNames.userTailorDetailPage,
                            extra: {
                              'tailorId': state
                                  .nearestTailors.nearestTailors![index].id,
                              'distance': state.nearestTailors
                                  .nearestTailors![index].distance
                            });
                      },
                      child: tailorHomePageCard(
                        nearestTailorData:
                            state.nearestTailors.nearestTailors![index],
                      ));
                },
              );
            }
          } else if (state is UserNearestTailorsLoadingState ||
              state is UserNearestTailorsInitialState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xFF000080),
                size: 50,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class BuildSearchNearestTailorsByAddressBlocConsumerWidget
    extends StatelessWidget {
  const BuildSearchNearestTailorsByAddressBlocConsumerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SearchNearestTailorsBloc, SearchNearestTailorsState>(
        listener: (context, state) {
          if (state is SearchNearestTailorsErrorState) {
            EasyLoading.showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is SearchNearestTailorsErrorState) {
            return Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
              child: Center(child: Text(state.message)),
            );
          } else if (state is SearchNearestTailorsSuccessState) {
            if (state.filteredNearestTailors.nearestTailors!.isEmpty) {
              return Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
                  child: Center(
                    child: Text(
                      'There are no tailors for the input address at the moment!',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Roboto-Regular",
                          fontSize: 20.h,
                          color: const Color(0xFF000080)),
                    ),
                  ));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.filteredNearestTailors.nearestTailors?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        debugPrint(
                            'Tailor Id is: ${state.filteredNearestTailors.nearestTailors![index].id}');
                        context.goNamed(AppRouteNames.userTailorDetailPage,
                            extra: {
                              'tailorId': state.filteredNearestTailors
                                  .nearestTailors![index].id,
                              'distance': state.filteredNearestTailors
                                  .nearestTailors![index].distance
                            });
                      },
                      child: tailorHomePageCard(
                        nearestTailorData:
                            state.filteredNearestTailors.nearestTailors![index],
                      ));
                },
              );
            }
          } else if (state is SearchNearestTailorsLoadingState ||
              state is SearchNearestTailorsInitialState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xFF000080),
                size: 50,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
