import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_innoscripta/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class ApiService {
  final Dio dio;
  final String baseUrl = 'https://api.todoist.com/rest/v2';
  final String token = 'a09eeac02ed4ef38c543e88a2f6d2515d85d2519';
  final SnackbarService _snackbarService;

  ApiService({
    Dio? dio,
    SnackbarService? snackbarService,
  })  : dio = dio ?? Dio(),
        _snackbarService = snackbarService ?? locator<SnackbarService>() {
    this.dio.options.baseUrl = baseUrl;
    this.dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, BuildContext? context}) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String path,
      {dynamic data, BuildContext? context}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String path,
      {dynamic data, BuildContext? context}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String path, {BuildContext? context}) async {
    try {
      return await dio.delete(path);
    } on DioException catch (e) {
      handleError(e);
      rethrow;
    }
  }

  void handleError(DioException e) {
    String errorMessage;
    if (e.response != null) {
      errorMessage =
          'API Error: ${e.response?.statusCode} ${e.response?.statusMessage}';
    } else {
      errorMessage = 'Network Error: ${e.message}';
    }

    _snackbarService.showSnackbar(
      message: errorMessage,
      duration: const Duration(seconds: 2),
    );
  }
}
