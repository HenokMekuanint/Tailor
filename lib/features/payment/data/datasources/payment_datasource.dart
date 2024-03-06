import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/constants/shared_pref_keys.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/payment/data/models/tailor_stripe_connect_response_model.dart';
import 'package:mobile/injection/user_auth_injection.dart';
import 'package:mobile/shared_pref/shared_pref_manager.dart';

abstract class StripePaymentDataSource {
  Future<TailorStripeConnectResonseModel> tailorCreateStripeAccountLink();
}

class StripePaymentDataSourceImpl implements StripePaymentDataSource {
  final http.Client client;

  // Share Preference Instance
  final prefManager = sl<SharedPrefManager>();
  StripePaymentDataSourceImpl({required this.client});

  @override
  Future<TailorStripeConnectResonseModel>
      tailorCreateStripeAccountLink() async {
    final token = prefManager.getString(SharedPrefKeys.token);
    try {
      final response = await client.post(
        Uri.parse(
            '${APIEndPoints.BASE_URL}${APIEndPoints.TailorConnectStripe}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final accountLinkCreated =
            TailorStripeConnectResonseModel.fromJson(jsonResponse);
        return accountLinkCreated;
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
}
