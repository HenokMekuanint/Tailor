import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';
import 'package:mobile/features/authentication/tailor/presentation/bloc/save_fcm_token/tailor_save_fcm_token_bloc.dart';

import 'package:mobile/features/home/tailor/presentation/tailor_availability_page.dart';
import 'package:mobile/features/authentication/tailor/presentation/screens/tailor_profile_page.dart';
import 'package:mobile/features/order/presentation/screens/tailor_order_page.dart';
import 'package:mobile/features/tailor_service/presentation/screens/tailor_service_page.dart';
import 'package:mobile/injection/injection_container.dart';

import 'package:mobile/shared_pref/shared_pref_manager.dart';

class tailorMainPage extends StatefulWidget {
  const tailorMainPage({super.key});

  @override
  State<tailorMainPage> createState() => _tailorMainPageState();
}

class _tailorMainPageState extends State<tailorMainPage> {
  int _currentIndex = 0;
  List<Widget> pages = [
    const TailorOrderPage(),
    const TailorServicePage(),
    const TailorAvailabilityPage(),
    const TailorProfilePage()
  ];
  final prefManager = sl<SharedPrefManager>();

  TailorModel? loggedTailorUser;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getLoggedInTailorInfo();

    getFcmToken();

    initInfo();
  }

  Future<void> getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('device fcm token is $token');
    String savedFcmToken = prefManager.getString(SharedPrefKeys.fcmToken) ?? '';
    if (loggedTailorUser != null && savedFcmToken.isEmpty ||
        token != savedFcmToken) {
      if (token != null) {
        if (prefManager.getString(SharedPrefKeys.userType) == 'tailor') {
          BlocProvider.of<TailorSaveFcmTokenBloc>(context)
              .add(SaveTailorFcmTokenEvent(fcmToken: token));
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

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTap,
    );

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

  void getLoggedInTailorInfo() {
    String? loggedInTailorString =
        prefManager.getString(SharedPrefKeys.loggedInTailorInfo);

    if (loggedInTailorString != null && loggedInTailorString.isNotEmpty) {
      loggedTailorUser = TailorModel.fromJson(jsonDecode(loggedInTailorString));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF000080),
        unselectedItemColor: const Color(0xFFC9C9C9),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30.sp,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30.sp,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_rounded,
                size: 30.sp,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30.sp,
              ),
              label: ''),
        ],
      ),
    );
  }
}
