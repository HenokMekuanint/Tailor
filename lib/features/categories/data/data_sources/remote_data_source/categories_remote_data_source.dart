import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/constants/api_end_points.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/categories/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await client.get(Uri.parse(
          '${APIEndPoints.BASE_URL}${APIEndPoints.TailorGetCategories}'));

      if (response.statusCode == 200) {
        List<CategoryModel> categories = [];

        final jsonData = json.decode(response.body);
        if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
          for (var item in (jsonData['data'] as List)) {
            categories.add(CategoryModel.fromJson(item));
          }
        }
        return categories;
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
            message: errorResponse['message'] ??
                'Internal Server Error ocurred while trying to get categories!');
      } else if (response.statusCode == 404) {
        final errorResponse = jsonDecode(response.body);
        throw NotFoundException(
            message: errorResponse['message'] ?? 'Resource not found!');
      } else {
        final errorResponse = jsonDecode(response.body);

        debugPrint('unknown errorResponse: $errorResponse');

        throw UnknownException(
            message: errorResponse['message'] ??
                'Unknown error occurred while getting categories!');
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
              'The server refused to connect while trying to get categories!');
    }
  }
}
