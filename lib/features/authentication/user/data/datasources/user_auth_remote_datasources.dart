// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/authentication/user/data/models/user_auth_model.dart';
import 'package:mobile/features/authentication/user/data/models/user_login_model.dart';
import 'package:mobile/features/authentication/user/data/models/user_update_profile_model.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_auth_entity.dart';
import 'package:mobile/features/authentication/user/domain/entities/user_login_entity.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

abstract class UserAuthRemoteDataSource {
  Future<UserModel> signUpUser(User user);

  Future<UserModel> signInUser(UserLogin user);

  Future<String> signOutUser(String user_type);
  Future<UserModel> updateProfile(UserUpdateProfileModel updateProfileModel);

  Future<UserModel> saveFcmToken(String fcmToken);

  Future<UserModel> updateProfilePicture(XFile imageFile);
}

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final http.Client client;

  // Share Preference Instance
  final prefManager = sl<SharedPrefManager>();

  UserAuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signInUser(UserLogin user) async {
    UserLoginModel userLoginModel = UserLoginModel(
      email: user.email,
      password: user.password,
      user_type: user.user_type,
    );

    try {
      final jsonBody = json.encode(userLoginModel.toJson());

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserLOGIN}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        prefManager.setString(SharedPrefKeys.token, jsonResponse['token']);
        debugPrint(
            'after login successfully, the profile pic url is : ${jsonResponse['user']['profile_picture']}');
        prefManager.setString(SharedPrefKeys.profilePictureUrl,
            jsonResponse['user']['profile_picture'] ?? "");
        prefManager.setString(
            SharedPrefKeys.fcmToken, jsonResponse['user']['fcm_token'] ?? "");
        final loggedInUser = UserModel.fromJson(jsonResponse['user']);

        return loggedInUser;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while signing in user');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
          message: 'Invalid format response exception occurred!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message: 'The server refused to connect while trying to login user');
    }
  }

  // Sign out
  @override
  Future<String> signOutUser(String user_type) async {
    debugPrint('user logout request jsonBody: $user_type');

    try {
      final jsonBody = json.encode({"user_type": user_type});
      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserLOGOUT}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final message = jsonResponse['message'];
        return message;
      } else if (response.statusCode == 401) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while signing out user');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
          message: 'Invalid format response exception occurred!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message: 'The server refused to connect while trying to logout user');
    }
  }

  Future<UserModel> signUpUser(User user) async {
    UserModel userModel = UserModel(
        email: user.email,
        password: user.password,
        address: user.address,
        name: user.name,
        phone: user.phone,
        user_type: user.user_type,
        fcm_token: user.fcm_token,
        profile_picture: user.profile_picture ?? "");

    debugPrint('user signup request jsonBody: ${userModel.toJson()}');

    try {
      final jsonBody = json.encode(userModel.toJson());

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserREGISTER}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint('user signup response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);

        final loggedInUser = UserModel.fromJson(jsonResponse['user']);
        return loggedInUser;
      } else if (response.statusCode == 401) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while signing up user');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
          message: 'Invalid format response exception occurred!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to sign up user');
    }
  }

  @override
  Future<UserModel> updateProfile(
      UserUpdateProfileModel updateProfileModel) async {
    debugPrint(
        'user update profile request jsonBody: ${updateProfileModel.toJson()}');

    try {
      final jsonBody = json.encode(updateProfileModel.toJson());

      final response = await client.put(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserUpdateProfile}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint('user update profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final loggedInUser = UserModel.fromJson(jsonResponse['user']);

        return loggedInUser;
      } else if (response.statusCode == 401) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while updating user profile');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
          message: 'Invalid format response exception occurred!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to update user profile');
    }
  }

  @override
  Future<UserModel> saveFcmToken(String fcmToken) async {
    debugPrint('user save fcm token request jsonBody: $fcmToken');

    try {
      final jsonBody =
          json.encode({"fcm_token": fcmToken, "user_type": "user"});
      final response = await client.put(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserSaveFcmToken}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint("Save fcm token response body");
      debugPrint('${json.decode(response.body)}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        prefManager.setString(
            SharedPrefKeys.fcmToken, jsonResponse['user']['fcm_token'] ?? "");
        final loggedInUser = UserModel.fromJson(jsonResponse['user']);
        return loggedInUser;
      } else if (response.statusCode == 401) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while saving fcm token');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');

      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    }
  }

  @override
  Future<UserModel> updateProfilePicture(XFile imageFile) async {
    debugPrint('user update profile picture request jsonBody: $imageFile');
    try {
      final request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${APIEndPoints.BASE_URL}${APIEndPoints.UserUpdateProfilePicture}'));
      request.headers.addAll({
        'Authorization': 'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
      });
      request.files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      debugPrint('user update profile picture response body: $responseString');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseString);
        debugPrint(
            'after updating profile picture successfully, the profile pic url is : ${jsonResponse['user']['profile_picture']}');
        prefManager.setString(SharedPrefKeys.profilePictureUrl,
            jsonResponse['user']['profile_picture'] ?? "");
        final loggedInUser = UserModel.fromJson(jsonResponse['user']);
        return loggedInUser;
      } else if (response.statusCode == 401) {
        final errorResponse = jsonDecode(responseString);
        debugPrint('unauthorized errorResponse: $responseString');
        throw UnAuthorizedException(
            message: errorResponse['message'] ?? 'UnAuthorized');
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(responseString);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
            message: errorResponse['message'] ??
                errorResponse['error'] ??
                "Invalid Input");
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: $responseString');
        final errorResponse = jsonDecode(responseString);
        throw InternalServerException(
            message:
                errorResponse['message'] ?? 'Internal Server Error ocurred!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(responseString);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(responseString);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while updating user profile picture');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
          message: 'Invalid format response exception occurred!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to update user profile picture');
    }
  }
}
