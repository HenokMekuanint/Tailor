import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';

import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';
import 'package:mobile/features/pick_up_date/data/models/delete.dart';
import 'package:mobile/features/pick_up_date/data/models/pick_up_date_model.dart';

import '../../models/create.dart';
import 'remote_data_source.dart';

class PickUpDateRemoteDataSourceImpl extends PickUpDateRemoteDataSource {
  PickUpDateRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  final String? _token = prefManager.getString(SharedPrefKeys.token);

  @override
  Future<PickUpDateModel> createPickUpDate(
      CreatePickUpDateModel createPickUpDateModel) async {
    try {
      final response = await client
          .post(
            Uri.parse(
                '${APIEndPoints.BASE_URL}${APIEndPoints.TailorPickUpDate}'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $_token'
            },
            body: jsonEncode(createPickUpDateModel.toJson()),
          )
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 201) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return PickUpDateModel.fromJson(responseJson['data']);
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ?? 'Unknown Error Occurred');
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
          message: 'Invalid format exception from the server!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to create the pick up date!');
    }
  }

  @override
  Future<DeletePickUpDateResponseModel> deletePickUpDate(int id) async {
    try {
      final response = await client.delete(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorPickUpDate}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return DeletePickUpDateResponseModel.fromJson(responseJson);
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Drop Off Date not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ?? 'Unknown Error Occurred');
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
          message: 'Invalid format exception from the server!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to delete the pick up date!');
    }
  }

  @override
  Future<PickUpDateModel> getPickUpDateById(int id) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorPickUpDate}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return PickUpDateModel.fromJson(responseJson['data']);
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Drop Off Date not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ?? 'Unknown Error Occurred');
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
          message: 'Invalid format exception from the server!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to get pick up date!');
    }
  }

  @override
  Future<List<PickUpDateModel>> getPickUpDates() async {
    try {
      final response = await client.get(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorPickUpDate}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return (responseJson['data'] as List)
            .map((e) => PickUpDateModel.fromJson(e))
            .toList();
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Drop Off Date not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ?? 'Unknown Error Occurred');
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
          message: 'Invalid format exception from the server!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to get pick up dates!');
    }
  }

  @override
  Future<PickUpDateModel> updatePickUpDate(
      PickUpDateModel pickUpDateModel) async {
    try {
      final response = await client
          .put(
            Uri.parse(
                '${APIEndPoints.BASE_URL}${APIEndPoints.TailorPickUpDate}/${pickUpDateModel.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_token'
            },
            body: jsonEncode(pickUpDateModel.toJsonForUpdate()),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return PickUpDateModel.fromJson(responseJson['data']);
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
            message: errorResponse['message'] ?? 'Internal Server Error');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Drop Off Date not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ?? 'Unknown Error Occurred');
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
          message: 'Invalid format exception from the server!');
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
          message:
              'The server refused to connect while trying to update the pick up date!');
    }
  }
}
