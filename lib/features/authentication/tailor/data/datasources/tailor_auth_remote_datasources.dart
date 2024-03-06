import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_auth_model.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_login_model.dart';
import 'package:mobile/features/authentication/tailor/data/models/tailor_update_profile_model.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_auth_entity.dart';
import 'package:mobile/features/authentication/tailor/domain/entities/tailor_login_entity.dart';

import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

abstract class TailorAuthRemoteDataSource {
  Future<TailorModel> signUpTailor(Tailor tailor);

  Future<TailorModel> signInTailor(TailorLogin tailor);

  Future<String> signOutTailor(String user_type);

  Future<TailorModel> updateProfile(
      TailorUpdateProfileModel tailorUpdateProfileModel);

  Future<TailorModel> saveFcmToken(String fcmToken);

  Future<TailorModel> updateProfilePicture(XFile imageFile);
}

class TailorAuthRemoteDataSourceImpl implements TailorAuthRemoteDataSource {
  final http.Client client;

  // Share Preference Instance
  final prefManager = sl<SharedPrefManager>();

  TailorAuthRemoteDataSourceImpl({required this.client});

  @override
  Future<TailorModel> signInTailor(TailorLogin tailor) async {
    TailorLoginModel tailorLoginModel = TailorLoginModel(
      email: tailor.email,
      password: tailor.password,
      user_type: tailor.user_type,
    );

    try {
      final jsonBody = json.encode(tailorLoginModel.toJson());
      debugPrint('tailor login request body: $jsonBody');

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorLOGIN}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));

      debugPrint('tailor login response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        debugPrint(
            'after login successfully, the profile pic url is : ${jsonResponse['tailor']['profile_picture']}');
        prefManager.setString(SharedPrefKeys.profilePictureUrl,
            jsonResponse['tailor']['profile_picture'] ?? "");
        prefManager.setString(SharedPrefKeys.token, jsonResponse['token']);
        prefManager.setString(
            SharedPrefKeys.fcmToken, jsonResponse['tailor']['fcm_token'] ?? "");
        debugPrint(
            'after login successfully,  the token from shared pref is : ${prefManager.getString(SharedPrefKeys.token)}');

        final loggedInTailor = TailorModel.fromJson(jsonResponse['tailor']);

        return loggedInTailor;
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
                'Unknown error occurred while logging in tailor');
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
              'The server refused to connect while trying to login tailor!');
    }
  }

  // Sign out
  @override
  Future<String> signOutTailor(String user_type) async {
    debugPrint('tailor logout request body: $user_type');

    final jsonBody = json.encode({"user_type": user_type});

    final token = prefManager.getString(SharedPrefKeys.token);
    debugPrint('token: $token');
    try {
      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorLOGOUT}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final message = jsonResponse['message'];
        return message;
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
                'Unknown error occurred while logging in tailor');
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
              'The server refused to connect while trying to logout tailor!');
    }
  }

  @override
  Future<TailorModel> signUpTailor(Tailor tailor) async {
    TailorModel tailorModel = TailorModel(
      email: tailor.email,
      password: tailor.password,
      address: tailor.address,
      name: tailor.name,
      phoneNumber: tailor.phoneNumber,
      user_type: tailor.user_type,
      latitude: tailor.latitude,
      longitude: tailor.longitude,
      services_summary: tailor.services_summary,
      stripe_account_id: tailor.stripe_account_id ?? "",
      stripe_onboarding_completed: tailor.stripe_onboarding_completed ?? false,
      fcm_token: tailor.fcm_token ?? "",
      profile_picture: tailor.profile_picture ?? "",
    );

    try {
      final jsonBody = json.encode(tailorModel.toJson());
      debugPrint('tailor register request body: $jsonBody');

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorREGISTER}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 30));

      debugPrint('tailor register response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);

        final loggedInTailor = TailorModel.fromJson(jsonResponse['tailor']);
        return loggedInTailor;
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
                'Unknown error occurred while logging in tailor');
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
              'The server refused to connect while trying to register tailor!');
    }
  }

  @override
  Future<TailorModel> updateProfile(
      TailorUpdateProfileModel tailorUpdateProfileModel) async {
    try {
      final jsonBody = json.encode(tailorUpdateProfileModel.toJson());
      debugPrint('tailor update request body: $jsonBody');

      final response = await client.put(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorUpdateProfile}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 30));

      debugPrint('tailor update profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final loggedInTailor = TailorModel.fromJson(jsonResponse['tailor']);
        return loggedInTailor;
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
                'Unknown error occurred while trying to update tailor profile!');
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
              'The server refused to connect while trying to update tailor profile!');
    }
  }

  @override
  Future<TailorModel> saveFcmToken(String fcmToken) async {
    try {
      final jsonBody =
          json.encode({"fcm_token": fcmToken, "user_type": "tailor"});
      debugPrint('tailor save fcm token request body: $jsonBody');

      final response = await client.put(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorSaveFcmToken}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 30));

      debugPrint('tailor save fcm token response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final loggedInTailor = TailorModel.fromJson(jsonResponse['tailor']);
        prefManager.setString(
            SharedPrefKeys.fcmToken, jsonResponse['tailor']['fcm_token'] ?? "");
        return loggedInTailor;
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
                'Unknown error occurred while trying to save fcm token!');
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
          message:
              'No Internet Connection. Please check your Internet connection and try again');
    }
  }

  @override
  Future<TailorModel> updateProfilePicture(XFile file) async {
    try {
      final token = prefManager.getString(SharedPrefKeys.token);
      final uri = Uri.parse(
          '${APIEndPoints.BASE_URL}${APIEndPoints.TailorUpdateProfilePicture}');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(
            await http.MultipartFile.fromPath('profile_picture', file.path));

      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      debugPrint(
          'tailor update profile picture response body: $responseString');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseString);

        final loggedInTailor = TailorModel.fromJson(jsonResponse['tailor']);
        debugPrint(
            'tailor update profile pic: profile pic uri: ${jsonResponse['tailor']['profile_picture']}');
        prefManager.setString(SharedPrefKeys.profilePictureUrl,
            jsonResponse['tailor']['profile_picture'] ?? "");
        return loggedInTailor;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
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
                'Unknown error occurred while trying to update tailor profile picture!');
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
              'The server refused to connect while trying to update tailor profile picture!');
    }
  }
}
