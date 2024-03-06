// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/tailor_service/data/models/service_model.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

abstract class ServiceRemoteDataSource {
  Future<ServiceModel> createService(ServiceEntity service);

  Future<ServiceModel> editService(ServiceEntity service);

  Future<bool> deleteService(String serviceId);
  Future<List<ServiceModel>> getServices();
}

final prefManager = sl<SharedPrefManager>();

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final http.Client client;

  // Share Preference Instance

  ServiceRemoteDataSourceImpl({required this.client});

  // Token
  final String? token = prefManager.getString(SharedPrefKeys.token);
  final String userType = prefManager.getString(SharedPrefKeys.userType)!;

  // Create Service
  @override
  Future<ServiceModel> createService(ServiceEntity service) async {
    ServiceModel serviceModel = ServiceModel(
      categoryId: service.categoryId,
      description: service.description,
      price: service.price,
      name: service.name,
    );

    debugPrint(
        'tailor createService request jsonBody: ${serviceModel.toJson()}');

    try {
      final jsonBody = json.encode(serviceModel.toJson());

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorService}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint('tailor createService response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);

        final createdService = ServiceModel.fromJson(jsonResponse['data']);
        return createdService;
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
              "Invalid Input",
        );
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
          message: errorResponse['message'] ?? 'Internal Server Error ocurred!',
        );
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
          message: errorResponse['message'] ?? 'Resource not found!',
        );
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
            'No Internet Connection. Please check your Internet connection and try again',
      );
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
        message: 'Invalid format response exception occurred!',
      );
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
        message:
            'The server refused to connect while trying to create service!',
      );
    }
  }

  // Edit Service

  @override
  Future<ServiceModel> editService(ServiceEntity service) async {
    ServiceModel serviceModel = ServiceModel(
        categoryId: service.categoryId,
        description: service.description,
        price: service.price,
        name: service.name,
        id: service.id);

    debugPrint('tailor editService request jsonBody: ${serviceModel.toJson()}');

    try {
      final jsonBody = json.encode(serviceModel.toJson());

      final response = await client.put(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorService}/${service.id}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint('tailor editService response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        debugPrint('tailor edit json response: ${jsonResponse['data']}');

        final editedService = ServiceModel.fromJson(jsonResponse['data']);
        debugPrint('tailor editedService response body: $editedService');
        return editedService;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
          message: errorResponse['message'] ?? 'UnAuthorized',
        );
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
          message: errorResponse['message'] ??
              errorResponse['error'] ??
              "Invalid Input",
        );
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
          message: errorResponse['message'] ?? 'Internal Server Error ocurred!',
        );
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
          message: errorResponse['message'] ?? 'Resource not found!',
        );
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
          message: errorResponse['message'] ??
              'Unknown error occurred while signing up user',
        );
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
        message:
            'No Internet Connection. Please check your Internet connection and try again',
      );
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
        message: 'Invalid format response exception occurred!',
      );
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
        message: 'The server refused to connect while trying to edit service!',
      );
    }
  }

  // Delete Service

  @override
  Future<bool> deleteService(String serviceId) async {
    try {
      final response = await client.delete(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorService}/$serviceId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      // debugPrint('tailor delete response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final errorResponse = jsonDecode(response.body);
        debugPrint('unauthorized errorResponse: ${response.body}');
        throw UnAuthorizedException(
          message: errorResponse['message'] ?? 'UnAuthorized',
        );
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);
        debugPrint(' invalid input errorResponse: $errorResponse');
        throw InvalidInputException(
          message: errorResponse['message'] ??
              errorResponse['error'] ??
              "Invalid Input",
        );
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
          message: errorResponse['message'] ?? 'Internal Server Error ocurred!',
        );
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
          message: errorResponse['message'] ?? 'Resource not found!',
        );
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
          message: errorResponse['message'] ??
              'Unknown error occurred while signing up user',
        );
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      throw const NoInternetException(
        message:
            'No Internet Connection. Please check your Internet connection and try again',
      );
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
        message: 'Invalid format response exception occurred!',
      );
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
        message:
            'The server refused to connect while trying to delete service!',
      );
    }
  }

  // Get Services
  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await client.get(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorService}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      // debugPrint(
      //     'user getServices response body: ${response.body}, ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Map Json List to List of Map
        final List<dynamic> jsonList = jsonResponse['data'];
        // debugPrint('tailor getServices json list: $jsonList,');

        // Map JsonList to service models
        final List<ServiceModel> services = jsonList
            .map((jsonObject) => ServiceModel.fromJson(jsonObject))
            .toList();

        return services;
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
              "Invalid Input",
        );
      } else if (response.statusCode == 500) {
        debugPrint(' internal server errorResponse: ${response.body}');
        final errorResponse = jsonDecode(response.body);
        throw InternalServerException(
          message: errorResponse['message'] ?? 'Internal Server Error ocurred!',
        );
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
          message: errorResponse['message'] ?? 'Resource not found!',
        );
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
            'No Internet Connection. Please check your Internet connection and try again',
      );
    } on TimeoutException catch (e) {
      debugPrint('TimeoutException: $e');
      throw const ConnectionTimeoutException(message: 'Connection Timeout');
    } on FormatException catch (e) {
      debugPrint('FormatException: $e');
      throw const UnknownException(
        message: 'Invalid format response exception occurred!',
      );
    } on http.ClientException catch (e) {
      debugPrint('ClientException: $e');
      throw const UnknownException(
        message: 'The server refused to connect while trying to get services!',
      );
    }
  }
}
