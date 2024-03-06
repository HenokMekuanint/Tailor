// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/order/data/models/create_order_model.dart';
import 'package:mobile/features/order/data/models/order_model.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

abstract class OrderRemoteDataSource {
  Future<CreateOrderModel> createOrder(CreateOrderEntity order);
  Future<List<OrderModel>> userGetOrders();
  Future<List<OrderModel>> tailorGetOrders();
  Future<OrderModel> userCompletePayment(String id);
}

final prefManager = sl<SharedPrefManager>();

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;

  // Share Preference Instance

  OrderRemoteDataSourceImpl({required this.client});

  // Token
  final String? token = prefManager.getString(SharedPrefKeys.token);
  final String userType = prefManager.getString(SharedPrefKeys.userType)!;

  // Create Order
  @override
  Future<CreateOrderModel> createOrder(CreateOrderEntity order) async {
    CreateOrderModel createOrderModel = CreateOrderModel(
      tailorId: order.tailorId,
      serviceId: order.serviceId,
      dropOffDate: order.dropOffDate,
      pickUpDate: order.pickUpDate,
    );

    debugPrint(
        'user create order request jsonBody: ${createOrderModel.toJson()}');
    debugPrint('user create order request token: $token');

    try {
      final jsonBody = json.encode(createOrderModel.toJson());

      final response = await client.post(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserOrders}'),
        body: jsonBody,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      debugPrint('user createService response body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);

        final createdOrder = CreateOrderModel.fromJson(jsonResponse['data']);
        return createdOrder;
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
        message: 'The server refused to connect while trying to create order!',
      );
    }
  }

  // Edit Service

  @override
  Future<List<OrderModel>> userGetOrders() async {
    try {
      final response = await client.get(
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.UserOrders}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Map Json List to List of Map
        final List<dynamic> jsonList = jsonResponse['data'];
        // debugPrint('tailor getServices json list: $jsonList,');

        // Map JsonList to service models
        final List<OrderModel> orders = jsonList
            .map((jsonObject) => OrderModel.fromJson(jsonObject))
            .toList();
        return orders;
      } else if (response.statusCode == 401) {
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
            'The server refused to connect while trying to get user orders!',
      );
    }
  }

  // tailor get orders

  @override
  Future<List<OrderModel>> tailorGetOrders() async {
    debugPrint('tailor getorders token: $token');
    debugPrint(
        'tailor getorder endpoint:  ${APIEndPoints.BASE_URL}${APIEndPoints.TailorOrders} ');
    try {
      final response = await client.get(
        // Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorOrders}'),
        Uri.parse('${APIEndPoints.BASE_URL}${APIEndPoints.TailorOrders}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));

      // print('tailor getorders response body: ${response.body},');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Map Json List to List of Map
        final List<dynamic> jsonList = jsonResponse['data'];

        // Map JsonList to service models
        final List<OrderModel> orders = jsonList
            .map((jsonObject) => OrderModel.fromJson(jsonObject))
            .toList();
        return orders;
      } else if (response.statusCode == 401) {
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
            'The server refused to connect while trying to get tailor orders!',
      );
    }
  }

  // User Complete Payment

  Future<OrderModel> userCompletePayment(String id) async {
    try {
      final body =
          jsonEncode({"payment_status": "completed", "status": "pending"});
      final response = await client.put(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.CompletePayment}/$id'),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 20));
      debugPrint(
          'user complete payment response status code: ${response.statusCode}');
      debugPrint('user complete payment response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return OrderModel.fromJson(jsonResponse['data']);
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
        message: 'The server refused to connect while trying to create order!',
      );
    }
  }
}
