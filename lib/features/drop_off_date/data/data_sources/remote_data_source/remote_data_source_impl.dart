import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/drop_off_date/data/models/delete.dart';
import 'package:mobile/features/drop_off_date/data/models/drop_off_date_model.dart';
import 'package:mobile/features/order/data/datasources/order_remote_datasource.dart';

import '../../models/create.dart';
import 'remote_data_source.dart';

class DropOffDateRemoteDataSourceImpl extends DropOffDateRemoteDataSource {
  DropOffDateRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  final String? _token = prefManager.getString(SharedPrefKeys.token);

  @override
  Future<DropOffDateModel> createDropOffDate(
      CreateDropOffDateModel createDropOffDateModel) async {
    try {
      final response = await client
          .post(
            Uri.parse(
                '${APIEndPoints.BASE_URL}${APIEndPoints.TailorDropOffDate}'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $_token'
            },
            body: jsonEncode(createDropOffDateModel.toJson()),
          )
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 201) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return DropOffDateModel.fromJson(responseJson['data']);
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
              'The server refused to connect while trying to create the drop off date!');
    }
  }

  @override
  Future<DeleteDropOffDateResponseModel> deleteDropOffDate(int id) async {
    try {
      final response = await client.delete(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorDropOffDate}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return DeleteDropOffDateResponseModel.fromJson(responseJson);
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
              'The server refused to connect while trying to delete the drop off date!');
    }
  }

  @override
  Future<DropOffDateModel> getDropOffDateById(int id) async {
    try {
      final response = await client.get(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorDropOffDate}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return DropOffDateModel.fromJson(responseJson['data']);
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
              'The server refused to connect while trying to get the drop off date!');
    }
  }

  @override
  Future<List<DropOffDateModel>> getDropOffDates() async {
    try {
      final response = await client.get(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorDropOffDate}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return (responseJson['data'] as List)
            .map((e) => DropOffDateModel.fromJson(e))
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
              'The server refused to connect while trying to get the drop off dates!');
    }
  }

  @override
  Future<DropOffDateModel> updateDropOffDate(
      DropOffDateModel dropOffDateModel) async {
    try {
      final response = await client
          .put(
            Uri.parse(
                '${APIEndPoints.BASE_URL}${APIEndPoints.TailorDropOffDate}/${dropOffDateModel.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_token'
            },
            body: jsonEncode(dropOffDateModel.toJson()),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        debugPrint('success responseJson: $responseJson');
        return DropOffDateModel.fromJson(responseJson['data']);
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
              'The server refused to connect while trying to update the drop off date!');
    }
  }
}
