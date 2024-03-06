import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailor_detail_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/get_nearest_tailors_request.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailors.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

import '../../models/search_nearest_tailors_by_address_request_model.dart';

abstract class NearestTailorsRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<NearestTailors> getNearestTailors(
      GetNearestTailorsRequestModel getNearestTailorsRequestModel);

  Future<NearestTailorDetail> getNearestTailorDetail(
      GetNearestTailorRequestModel getNearestTailorRequestModel);

  Future<NearestTailors> searchNearestTailorsByAddress(
      SearchNearestTailorsByAddressRequestModel
          searchNearestTailorsByAddressRequestModel);
}

class NearestTailorsRemoteDataSourceImpl
    implements NearestTailorsRemoteDataSource {
  final http.Client client;

  final prefManager = sl<SharedPrefManager>();

  NearestTailorsRemoteDataSourceImpl({required this.client});

  @override
  Future<NearestTailors> getNearestTailors(
      GetNearestTailorsRequestModel getNearestTailorsRequestModel) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.NearestTailors}?latitude=${getNearestTailorsRequestModel.latitude}&longitude=${getNearestTailorsRequestModel.longitude}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return NearestTailors.fromJson(jsonDecode(response.body));
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
                errorResponse['message'] ?? 'Internal Server Error ocurred');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Nearest tailors not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while getting nearest tailors');
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
              'The server refused to connect while trying to get nearest tailors');
    }
  }

  @override
  Future<NearestTailorDetail> getNearestTailorDetail(
      GetNearestTailorRequestModel getNearestTailorRequestModel) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.NearestTailorDetail}/${getNearestTailorRequestModel.id}/details'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return NearestTailorDetail.fromJson(jsonDecode(response.body));
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Nearest tailors not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while getting nearest tailors');
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
              'The server refused to connect while trying to get nearest tailor details');
    }
  }

  @override
  Future<NearestTailors> searchNearestTailorsByAddress(
      SearchNearestTailorsByAddressRequestModel searchModel) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.searchNearestTailorsByAddress}?latitude=${searchModel.latitude}&longitude=${searchModel.longitude}&query_string=${searchModel.queryString}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${prefManager.getString(SharedPrefKeys.token)}'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return NearestTailors.fromJson(jsonDecode(response.body));
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
                errorResponse['message'] ?? 'Internal Server Error ocurred');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Nearest tailors not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while getting nearest tailors');
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
    }
  }
}
