import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/persisted_shared_pref_manager.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<OnBoarding> {
  Position? _currentPosition;
  String? selectedAccountType;
  final prefManager = sl<SharedPrefManager>();

  final _persistentPrefs = sl<PersistedSharePrefManager>();
  bool _isLocationEnabledAndShared = false;

  // Check if location service is enabled and update preferences accordingly
  Future<void> _checkLocationServiceStatus() async {
    final bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // If location service is disabled, reset the variable in persistent shared preferences
      _persistentPrefs.isLocationEnableAndShared = false;
    }
  }

  // Handle location permission logic
  Future<bool> _handleLocationPermission() async {
    // Check if location permission has already been asked
    bool locationPermissionAsked =
        _persistentPrefs.isLocationEnableAndShared ?? false;
    if (locationPermissionAsked) {
      // Recheck location service status each time user logs in
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        return false;
      }
      return true;
    }
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      EasyLoading.showError(
          'Please enable location services in your settings!');
      final result = await Geolocator.openLocationSettings();
      if (result) {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      }
    }

    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request location service and permission
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        EasyLoading.showError(
            'You have denied this app from accessing your location!');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      final result = await Geolocator.openAppSettings();
      if (result) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        EasyLoading.showError(
            'You have denied this app from accessing your location!');
        return false;
      }
    }

    _persistentPrefs.isLocationEnableAndShared = true;

    return true;
  }

  // Get the current position
  Future<bool> _getCurrentPosition() async {
    try {
      final hasPermission = await _handleLocationPermission();

      debugPrint('hasPermission: $hasPermission');

      if (!hasPermission) {
        setState(() {
          _isLocationEnabledAndShared = false;
        });

        return false;
      }

      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _isLocationEnabledAndShared = true;
      });

      prefManager.setDouble(
          SharedPrefKeys.latitude, _currentPosition?.latitude ?? 0.0);
      prefManager.setDouble(
          SharedPrefKeys.longitude, _currentPosition?.longitude ?? 0.0);

      debugPrint('latitude: ${_currentPosition?.latitude}');
      debugPrint('longitude: ${_currentPosition?.longitude}');
      _persistentPrefs.isLocationEnableAndShared = true;

      return true;
    } catch (e) {
      debugPrint('Error getting current position: $e');
      return false;
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings notificationSettings =
        await messaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    _checkLocationServiceStatus();
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.white,
        toolbarHeight: 80.h,
        backgroundColor: const Color(0xFF000080),
        title: Text(
          "Welcome to ThreadMe",
          style: TextStyle(
              fontFamily: "Roboto-Medium", color: Colors.white, fontSize: 30.h),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Image.asset(
                "assets/launcher_icons/launcher.png",
                width: 440.w,
                height: 440.h,
              ),
            ),
            Text(
              "SignUp/Login",
              style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontSize: 24.h,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text above radio buttons
                Column(
                  children: [
                    Text(
                      " As User",
                      style: TextStyle(
                          fontFamily: "Roboto-Regular",
                          color: Colors.black,
                          fontSize: 20.h),
                    ),
                    Radio<String>(
                      activeColor: const Color(0xFF000080),
                      value: 'user',
                      groupValue: selectedAccountType,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAccountType = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "As Tailor",
                      style: TextStyle(
                          fontFamily: "Roboto-Regular",
                          color: Colors.black,
                          fontSize: 20.h),
                    ),
                    Radio<String>(
                      activeColor: const Color(0xFF000080),
                      value: 'tailor',
                      groupValue: selectedAccountType,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAccountType = value!;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  // await _getCurrentPosition();
                  if (selectedAccountType == null ||
                      selectedAccountType!.isEmpty) {
                    EasyLoading.showError('Please select an account type');

                    return;
                  } else {
                    await _getCurrentPosition();

                    if (_persistentPrefs.isLocationEnableAndShared == true) {
                      if (selectedAccountType == "user") {
                        prefManager.setString(SharedPrefKeys.userType, 'user');
                        Future.delayed(const Duration(seconds: 1), () {
                          context.go(
                            '/${AppRouteNames.userLogin}',
                            // extra: 'User Type',
                          );
                        });
                      } else if (selectedAccountType == "tailor") {
                        prefManager.setString(
                            SharedPrefKeys.userType, 'tailor');
                        Future.delayed(const Duration(seconds: 1), () {
                          context.go('/${AppRouteNames.tailorLoginPage}');
                        });
                      } else {
                        EasyLoading.showError('Please select user type');
                        return;
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: Size(350.w, 70.h),
                  backgroundColor: const Color(0xFF000080),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      fontSize: 25.h,
                      color: Colors.white,
                      fontFamily: "Roboto-Medium"),
                ))
          ],
        ),
      ),
    );
  }
}
