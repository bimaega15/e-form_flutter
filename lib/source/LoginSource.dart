// ignore_for_file: unnecessary_new, avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/utils.dart';

class LoginSource {
  static Future signIn(
    String email,
    String password,
    String? fcmToken,
  ) async {
    try {
      Dio dio = Dio();
      dio.options.validateStatus = (_) => true;
      Response response = await dio.post('${ApiService.baseUrl}/login', data: {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Utils().printError(response.data);
      }
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }

  static Future systemLogout(
    String fcmToken,
  ) async {
    try {
      Dio dio = Dio();
      dio.options.validateStatus = (_) => true;
      Response response = await dio.post('${ApiService.baseUrl}/logout', data: {
        'fcmToken': fcmToken,
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Utils().printError(response.data);
      }
    } catch (e) {
      print(e);
      // Utils().showSnackbar('error', 'Failed', 'Terjadi kesalahan');
    }
  }
}
