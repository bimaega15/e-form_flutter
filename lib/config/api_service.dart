// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/session.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/controller/c_auth.dart';
import 'package:get/get.dart' hide Response;

class ApiService {
  static const String baseUrl =
      "https://9806-2400-9800-630-8395-6cdc-4a52-f84f-390b.ngrok-free.app/e_form/public/api";
  static const String baseRoot =
      "https://9806-2400-9800-630-8395-6cdc-4a52-f84f-390b.ngrok-free.app/e_form/public";
  CAuth cAuth = Get.put(CAuth());

  Dio _dio = Dio();

  ApiService() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 60 * 1000),
        receiveTimeout: const Duration(milliseconds: 60 * 1000),
        validateStatus: (_) => true);

    _dio = Dio(options);
    _dio.options.headers = _getOptions();
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters = const {}}) async {
    try {
      Response response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (error) {
      throw _handleError(error);
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (error) {
      throw _handleError(error);
    }
  }

  Map<String, dynamic> _getOptions() {
    String token = cAuth.authData.value.token;
    Map<String, dynamic> options = {};

    if (token.isNotEmpty) {
      options = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    } else {
      options = {"Content-Type": "application/json"};
    }

    return options;
  }

  DioException _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        if (error.type == DioExceptionType.connectionTimeout) {
          Utils().showSnackbar('error', 'Failed', 'Connection time out');
        }
        if (error.response!.statusCode == 401) {
          Session.clearUser();
          Get.toNamed(AppRoute.login);
        }
      } else {
        // Tidak ada respons dari server
        print("DioError: ${error.message}");
      }
      return error;
    } else {
      print("Error: $error");
      return DioException(
          error: 'Terjadi kesalahan',
          message: error.toString(),
          requestOptions: RequestOptions());
    }
  }
}
